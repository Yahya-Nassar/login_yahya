// ignore_for_file: unused_import, unused_element, sized_box_for_whitespace
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:login_yahya/controls/services/category_service.dart';
import 'package:login_yahya/controls/services/order_service.dart';
import 'package:provider/provider.dart';
import 'package:login_yahya/model/category_model.dart';
import 'package:login_yahya/model/item_model.dart';
import 'package:login_yahya/controls/services/item_service.dart';
import 'package:login_yahya/utils/app_colors.dart';
import 'package:login_yahya/utils/app_images.dart';
import 'package:login_yahya/utils/app_spaces.dart';
import 'package:login_yahya/utils/app_styles.dart';

class LeftHome extends StatefulWidget {
  const LeftHome({super.key});

  @override
  State<LeftHome> createState() => _LeftHomeState();
}

class _LeftHomeState extends State<LeftHome> {
  @override
  void initState() {
    super.initState();
    _fetchInitialData();
  }

  void _fetchInitialData() {
    final categoryService =
        Provider.of<CategoryService>(context, listen: false);
    final itemService = Provider.of<ItemService>(context, listen: false);

    categoryService.getCategories();
    itemService.getItems(categoryService.getIndexCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CategoryService, ItemService, OrderService>(
      builder: (context, categoryService, itemService, orderService, child) {
        if (categoryService.categoryModel == null) {
          return const CenterLoadingIndicator();
        }
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderRow(),
              SpacesApp.spaceH_10,
              _CategorySelector(categoryService, itemService),
              const _SectionTitle(title: "Fried"),
              _ItemGrid(itemService, orderService),
            ],
          ),
        );
      },
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ImageApp.logo,
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Icon(
          Icons.language_outlined,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final CategoryService categoryService;
  final ItemService itemService;

  const _CategorySelector(this.categoryService, this.itemService);

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: AppColors.backGroundCategoryColor,
      borderRadius: 10,
      spread: 1,
      emboss: true,
      depth: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose From Main Categories",
              style: StylesApp.titleDescStyle,
            ),
            SpacesApp.spaceH_10,
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoryService.categoryModel!.data!.length,
                itemBuilder: (context, index) {
                  return _CategoryItem(
                    index: index,
                    categoryService: categoryService,
                    itemService: itemService,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final int index;
  final CategoryService categoryService;
  final ItemService itemService;

  const _CategoryItem({
    required this.index,
    required this.categoryService,
    required this.itemService,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        categoryService.setIndexCategory = index + 1;
        itemService.itemModel = null;
        await itemService.getItems(index + 1);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClayContainer(
          color: AppColors.white,
          surfaceColor: categoryService.getIndexCategory == index + 1
              ? AppColors.scondryColor
              : null,
          parentColor: AppColors.scondryColor,
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.07,
          spread: 1,
          child: Center(
            child: Text(
              categoryService.categoryModel!.data![index].name!,
              style: categoryService.getIndexCategory == index + 1
                  ? StylesApp.categoryNormalStyleSelect
                  : StylesApp.categoryNormalStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemGrid extends StatelessWidget {
  final ItemService itemService;
  final OrderService orderService;

  const _ItemGrid(this.itemService, this.orderService);

  @override
  Widget build(BuildContext context) {
    if (itemService.itemModel == null) {
      return const CenterLoadingIndicator();
    }

    return Flexible(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: GridView.builder(
          itemCount: itemService.itemModel!.data.length * 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            final actualIndex = index % itemService.itemModel!.data.length;
            final categoryIndex =
                itemService.itemModel!.data[actualIndex].categoryId;
            final imagePath =
                CategoryImageProvider.getImageForCategory(categoryIndex);

            return _ItemTile(
              item: itemService.itemModel!.data[actualIndex],
              orderService: orderService,
              imagePath: imagePath,
            );
          },
        ),
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  final item;
  final OrderService orderService;
  final String imagePath;

  const _ItemTile({
    required this.item,
    required this.orderService,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        orderService.setItemOrder = item;
        orderService.calc();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            ),
            Text(item.name.toString(), style: StylesApp.normalStyle),
            Text(item.price.toString(), style: StylesApp.priceNormalStyle),
          ],
        ),
      ),
    );
  }
}

/*
class _ItemGrid extends StatelessWidget {
  final ItemService itemService;
  final OrderService orderService;

  const _ItemGrid(this.itemService, this.orderService);

  @override
  Widget build(BuildContext context) {
    if (itemService.itemModel == null) {
      return const CenterLoadingIndicator();
    }

    return Flexible(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: GridView.builder(
          itemCount: itemService.itemModel!.data.length * 5,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemBuilder: (context, index) {
            final actualIndex = index % itemService.itemModel!.data.length;
            return _ItemTile(
              item: itemService.itemModel!.data[actualIndex],
              orderService: orderService,
            );
          },
        ),
      ),
    );
  }
}
*/

/*
class _ItemTile extends StatelessWidget {
  final item;
  final OrderService orderService;

  const _ItemTile({
    required this.item,
    required this.orderService,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        orderService.setItemOrder = item;
        orderService.calc();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                ImageApp.foodChicken, //Image.network(item.imagePath.toString(),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                /*loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CenterLoadingIndicator();
                },*/
              ),
            ),
            Text(item.name.toString(), style: StylesApp.normalStyle),
            Text(item.price.toString(), style: StylesApp.priceNormalStyle),
          ],
        ),
      ),
    );
  }
}
*/
class CenterLoadingIndicator extends StatelessWidget {
  const CenterLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8),
      child: Text(title, style: StylesApp.titleDescStyle),
    );
  }
}
