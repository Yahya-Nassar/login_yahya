// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import '../../model/login_model.dart';
import 'package:login_yahya/model/user_model.dart';
import 'package:login_yahya/utils/app_url.dart';
import 'package:dio/dio.dart';

class LoginService with ChangeNotifier {
  Dio dio = Dio();
  bool? _isLoading = false;

  get getIsloading => _isLoading;

  set setisLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> login(LoginPost login) async {
    bool res = false;
    final response = await dio
        .post(Urls.baseUrl + Urls.loginUrl, data: loginPostToJson(login))
        .then((value) {
      var user = UserModel.fromJson(value.data);

      if (user.success == true) {
        res = true;
        print(user.data!.name);
      } else {
        print(user.message);
      }
      notifyListeners();
    }).catchError((onError) {
      print(onError);
    });

    return res;
  }
}
