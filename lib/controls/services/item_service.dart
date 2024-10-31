// ignore_for_file: avoid_print, unused_local_variable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_yahya/model/item_model.dart';
import 'package:login_yahya/utils/app_url.dart';

class ItemService with ChangeNotifier {
  Dio dio = Dio();
  ItemModel? itemModel;

  Future<ItemModel> getItems(id) async {
    bool res = false;
    print("###########################");
    print(Urls.baseUrl + Urls.itemUrl);
    print("###########################");
    final response = await dio.get(Urls.baseUrl + Urls.itemUrl,
        queryParameters: {"categoryId": id}).then((value) {
      itemModel = ItemModel.fromJson(value.data);

      if (itemModel!.success == true) {
        res = true;
        return itemModel!;
      } else {
        print(itemModel!.message);
      }
      notifyListeners();
    }).catchError((onError) {
      print(onError);
      return onError;
    });
    notifyListeners();
    return itemModel!;
  }
}
