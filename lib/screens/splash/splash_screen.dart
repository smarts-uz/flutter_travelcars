import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/choice_language.dart';
import 'package:travelcars/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static String? til;
  static String? kurs;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigatorHome();
  }
  
  _navigatorHome() async {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      final prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey("isFirst")) {
        switch(jsonDecode(prefs.getString("settings")!)["locale"]) {
          case "ENG":
          SplashScreen.til = "en";
            break;
          case "RUS":
            SplashScreen.til = "ru";
            break;
          case "UZB":
            SplashScreen.til = "uz";
            break;
        }
        SplashScreen.kurs = jsonDecode(prefs.getString("settings")!)["currency"];
        HomeScreen.isLoading = true;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
        print(SplashScreen.til);
        print(SplashScreen.kurs);
      } else {
        prefs.setBool("isFirst", true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ChoicePage()));
      }
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       // height: MediaQuery.of(context).size.height*0.9,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 192),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .45,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                Container(
                  child: Text(
                    "2018 - 2021 Travel Cars\n Все права защищены",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
