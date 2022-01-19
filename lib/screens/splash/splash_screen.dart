import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/choice_language.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

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
        print(AppConfig.url);
      } else {
        prefs.setBool("isFirst", true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ChoicePage()));
      }
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20,top: 20),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * .8,
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 300,
                    width: 200,
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Text(
                  "2018 - ${DateFormat('yyyy').format(DateTime.now())} Travel Cars\n ${LocaleKeys.All_rights_reserved.tr()}",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
