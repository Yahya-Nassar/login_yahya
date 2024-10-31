// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:login_yahya/pages/login.dart';
import 'package:login_yahya/controls/services/login_service.dart';
import 'package:provider/provider.dart';
import 'package:login_yahya/routes/app_route.dart';
import 'package:login_yahya/pages/home.dart';
import 'package:login_yahya/controls/services/category_service.dart';
import 'package:login_yahya/controls/services/item_service.dart';
import 'package:login_yahya/controls/services/order_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        onGenerateRoute: OnGenerateRoute.generateRoute,
      ),
    );
    /* return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );*/
  }
}
