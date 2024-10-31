// ignore_for_file: unused_import, prefer_conditional_assignment, unused_local_variable, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_yahya/model/item_model.dart';
import 'package:login_yahya/model/order_model.dart';
import 'package:login_yahya/utils/app_url.dart';
import 'package:login_yahya/model/result_model.dart';
import 'IOrderService.dart';

class OrderService with ChangeNotifier {
  Dio dio = Dio();
  OrderModel _order = OrderModel();

  OrderModel get getOrder => _order;

  set setOrder(value) {
    _order = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get getIsLoading => _isLoading;

  set setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  set setItemOrder(value) {
    _order.items.add(value);
    notifyListeners();
  }

  bool _checkoutDone = false;
  get getCheckoutDone => _checkoutDone;
  set setCheckoutDone(value) {
    _checkoutDone = value;
    notifyListeners();
  }

  calc() {
    _order.subTotal = 0;
    _order.total = 0;

    for (var item in _order.items) {
      _order.subTotal = _order.subTotal + item.price;
    }
    _order.total = _order.subTotal;
    _order.discount = 0;
    _order.vat = 0;

    notifyListeners();
  }

  deleteItem(index) {
    _order.items.removeAt(index);
    calc();
    notifyListeners();
  }

  Future<bool> checkout() async {
    setIsLoading = true;

    final response = await dio
        .post(Urls.baseUrl + Urls.checkoutUrl, data: orderModelToJson(_order))
        .then((value) {
      var result = ResultModel.fromJson(value.data);
      print(value.data.toString());

      if (result.success == true) {
        setCheckoutDone = true;
        print(result.message);
      } else {
        print(result.message);
      }
      notifyListeners();
    }).catchError((onError) {
      print(onError);
    });
    setIsLoading = false;
    return getCheckoutDone;
  }

  clearOrder() {
    setCheckoutDone = false;
    _order.subTotal = 0;
    _order.total = 0;
    _order.items.clear();
    notifyListeners();
  }

  // ignore: unused_element
  bool _isValidItemIndex(int index) {
    return index >= 0 && index < (_order.items.length);
  }

  void decreaseQuantity(int index) {
    if (_order.items[index].quantity > 1) {
      _order.items[index].quantity--;
      notifyListeners();
    }
  }

  void increaseQuantity(int index) {
    _order.items[index].quantity++;
    notifyListeners();
  }
}
