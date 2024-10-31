// ignore_for_file: unused_import, unnecessary_null_comparison
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:login_yahya/pages/checkout.dart';
import 'package:login_yahya/controls/services/order_service.dart';
import 'package:provider/provider.dart';
import 'package:login_yahya/controls/services/item_service.dart';
import 'package:login_yahya/utils/app_spaces.dart';
import 'package:login_yahya/utils/app_styles.dart';
import 'package:login_yahya/utils/app_colors.dart';
import 'package:login_yahya/utils/app_images.dart';
import '../model/item_model.dart';

class RightHome extends StatelessWidget {
  const RightHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClayContainer(
        color: AppColors.backGroundCategoryColor,
        spread: 1,
        borderRadius: 10,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            _buildCartHeader(context),
            Expanded(child: _buildCartItemsList()),
            SpacesApp.spaceH_10,
            _buildPaymentSummary(),
            SpacesApp.spaceH_20,
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCartHeader(BuildContext context) {
    final orderService = Provider.of<OrderService>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "My Cart (${orderService.getOrder.items.length})",
            style: StylesApp.titleDescStyle,
          ),
          GestureDetector(
            onTap: orderService.clearOrder,
            child: Text("Clear All", style: StylesApp.normalStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList() {
    return Consumer<OrderService>(
      builder: (context, orderService, _) {
        final items = orderService.getOrder.items;
        if (items.isEmpty) {
          return Center(
            child: Text("No items in the cart.", style: StylesApp.normalStyle),
          );
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildCartItem(item, index, context);
          },
        );
      },
    );
  }

  Widget _buildCartItem(ItemData item, int index, BuildContext context) {
    final orderService = Provider.of<OrderService>(context, listen: false);
    return ListTile(
      leading: _buildItemImage(item, index),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemHeader(item, index, orderService),
          SpacesApp.spaceH_10,
          _buildQuantityControls(context, index),
          Text("${item.price}", style: StylesApp.itemNameStyle),
        ],
      ),
    );
  }

  Widget _buildItemImage(ItemData item, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        CategoryImageProvider.getImageForCategory(item.categoryId),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error);
        },
      ),
    );
  }

  Widget _buildItemHeader(ItemData item, int index, OrderService orderService) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(item.name, style: StylesApp.itemNameStyle),
        IconButton(
          onPressed: () => orderService.deleteItem(index),
          icon: Icon(Icons.delete, color: AppColors.scondryColor, size: 20),
        ),
      ],
    );
  }

  Widget _buildQuantityControls(BuildContext context, int index) {
    return Consumer<OrderService>(
      builder: (context, orderService, _) {
        return Row(
          children: [
            _buildQuantityButton("-", () {
              orderService.decreaseQuantity(index);
            }),
            SpacesApp.spaceW_10,
            Text(
              "${orderService.getOrder.items[index].quantity}",
              style: StylesApp.itemNameStyle,
            ),
            SpacesApp.spaceW_10,
            _buildQuantityButton("+", () {
              orderService.increaseQuantity(index);
            }),
          ],
        );
      },
    );
  }

  Widget _buildQuantityButton(String symbol, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: ClayContainer(
        spread: 0,
        color: AppColors.primaryColor,
        borderRadius: 5,
        width: 30,
        height: 30,
        child: Center(
          child: Text(symbol, style: StylesApp.minusStyleSelect),
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Consumer<OrderService>(
      builder: (context, orderService, _) {
        final order = orderService.getOrder;
        return Column(
          children: [
            _buildSummaryRow("SubTotal", order.subTotal),
            const Divider(),
            _buildSummaryRow("Discount", 0.0),
            const Divider(),
            _buildSummaryRow("VAT", 0.0),
            const Divider(),
            _buildSummaryRow("Total", order.total),
          ],
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: StylesApp.calcStyle),
          Text(value.toStringAsFixed(2), style: StylesApp.calcStyle),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    final orderService = Provider.of<OrderService>(context, listen: false);
    return FilledButton(
      style: FilledButton.styleFrom(
        fixedSize: Size(
          MediaQuery.of(context).size.width * 0.2,
          MediaQuery.of(context).size.height * 0.01,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      onPressed: () {
        if (orderService.getOrder.items.isNotEmpty) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return const Checkout();
            },
          );
        }
      },
      child: const Text("Checkout"),
    );
  }
}
