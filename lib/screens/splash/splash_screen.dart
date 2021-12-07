import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/login/choice_language.dart';
import 'package:travelcars/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatorHome();
  }
  
  _navigatorHome() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
      /*final prefs = await SharedPreferences.getInstance();
      if(prefs.containsKey('userData'))
      {
        final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
        final expiryDate = DateTime.parse(extractedUserData['expiry_at'].substring(0, 10));
        if(expiryDate.isAfter(DateTime.now())) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ChoicePage()));
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ChoicePage()));
      }*/
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
                        fontSize: 20,
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
