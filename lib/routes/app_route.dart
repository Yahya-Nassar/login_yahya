import 'package:flutter/material.dart';
import 'package:login_yahya/routes/app_route_list.dart';
import 'package:login_yahya/pages/home.dart';
import 'package:login_yahya/pages/login.dart';
import 'package:login_yahya/controls/widgets/error_screen.dart';

class OnGenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // ignore: unused_local_variable
    final parm = routeSettings.arguments;
    switch (routeSettings.name) {
      case RouteList.home:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const HomeScreen());
      case RouteList.login:
        return MaterialPageRoute(
            settings: routeSettings, builder: (_) => const LoginScreen());
      default:
        return errorPage(routeSettings);
    }
  }

  static Route<dynamic> errorPage(RouteSettings routeSttings) {
    return MaterialPageRoute(builder: (_) => const ErrorScreen());
  }
}
