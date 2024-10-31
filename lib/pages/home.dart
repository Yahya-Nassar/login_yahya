import 'package:flutter/material.dart';
import 'package:login_yahya/pages/left_home.dart';
import 'package:login_yahya/pages/right_home.dart';
import 'package:login_yahya/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /*appBar: AppBar(
      actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, 'login_yahya/screens/Login');
              //Navigator.of(context).pushReplacementNamed('/Login');
            },
            child: const Text('Go Login'),
          ),
        ],
      ),*/
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Expanded(flex: 7, child: LeftHome()),
          Expanded(flex: 3, child: RightHome()),
        ],
      ),
    );
  }
}
