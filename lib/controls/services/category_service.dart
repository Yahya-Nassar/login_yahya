// ignore_for_file: unused_local_variable, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_yahya/model/category_model.dart';
import 'package:login_yahya/utils/app_url.dart';

class CategoryService with ChangeNotifier {
  Dio dio = Dio();
  CategoryModel? categoryModel;
  int? _indexCategory = 1;

  get getIndexCategory => _indexCategory;

  set setIndexCategory(value) {
    _indexCategory = value;
    notifyListeners();
  }

  Future<CategoryModel> getCategories() async {
    bool res = false;
    final response = await dio
        .get(
      Urls.baseUrl + Urls.categoryUrl,
    )
        .then((value) {
      print(value);
      categoryModel = CategoryModel.fromJson(value.data);

      if (categoryModel!.success == true) {
        res = true;
      } else {
        //print(categoryModel!.message);
      }
      notifyListeners();
    }).catchError((onError) {
      print("#######################");
      print(onError);
      print("#######################");
    });
    notifyListeners();
    return categoryModel!;
  }
}
