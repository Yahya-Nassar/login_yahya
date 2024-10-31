// ignore_for_file: unused_import, avoid_print
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:login_yahya/model/login_model.dart';
import 'package:login_yahya/controls/services/login_service.dart';
import 'package:login_yahya/utils/app_colors.dart';
import 'package:login_yahya/utils/app_images.dart';
import 'package:login_yahya/utils/app_spaces.dart';
import 'package:login_yahya/utils/app_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var loginService = Provider.of<LoginService>(
      context,
    );

    return Scaffold(
      body: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: const Color(0xffEAFAFF),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpacesApp.spaceH_50,
                    SpacesApp.spaceH_50,
                    Image.asset(
                      ImageApp.logo,
                      width: MediaQuery.of(context).size.width * 0.2,
                    ),
                    SpacesApp.spaceH_50,
                    SpacesApp.spaceH_20,
                    ClayContainer(
                      spread: 1,
                      borderRadius: 10,
                      parentColor: AppColors.primaryColor,
                      child: Image.asset(
                        ImageApp.logoHMS,
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    //width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      children: <Widget>[
                        SpacesApp.spaceH_20,
                        SpacesApp.spaceH_10,
                        FittedBox(
                          child: Text(
                            "Login",
                            style: GoogleFonts.concertOne(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(
                                    255, 0, 0, 0), //color: Color(0xff004F62),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ), //StylesApp.titleStyle
                        FittedBox(
                          child: Text("Hi, User Please Login to Continue",
                              style: StylesApp.titleDescStyle),
                        ), //StylesApp.titleDescStyle
                      ],
                    ),
                  ),
                  SpacesApp.spaceH_20,
                  //SpacesApp.spaceH_10,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          child: Text(
                            "User Name",
                            style: StylesApp.normalStyle,
                          ),
                        ),
                        //SpacesApp.spaceH_10,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: TextFormField(
                            controller: username,
                            style: StylesApp.normalStyle,
                            decoration: InputDecoration(
                              hintText: "User Name",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        SpacesApp.spaceH_20,
                        FittedBox(
                          child: Text(
                            "Password",
                            style: StylesApp.normalStyle,
                          ),
                        ),
                        //SpacesApp.spaceH_10,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          child: TextFormField(
                            controller: password,
                            obscureText: true,
                            style: StylesApp.normalStyle,
                            decoration: InputDecoration(
                              hintText: "Password",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: AppColors.primaryColor)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SpacesApp.spaceH_50,
                  //SpacesApp.spaceH_50,
                  loginService.getIsloading
                      ? CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : FittedBox(
                          child: FilledButton(
                            onPressed: () async {
                              loginService.setisLoading = true;
                              var res = await loginService.login(
                                LoginPost(
                                    userName: username.text,
                                    password: password.text),
                              );
                              if (res == true) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/Home');
                              } else {
                                loginService.setisLoading = false;
                                print("wrong");
                              }
                            },
                            style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1,
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                backgroundColor: AppColors.primaryColor),
                            child: Text("Login", style: StylesApp.normalStyle),
                          ),
                        ),
                  SpacesApp.spaceH_10,
                  SpacesApp.spaceH_20,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.desktop_windows_sharp,
                          color: AppColors.theirdColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.tablet_android,
                          color: AppColors.theirdColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.language,
                          color: AppColors.theirdColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.sync,
                          color: AppColors.theirdColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
