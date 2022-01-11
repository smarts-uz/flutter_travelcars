import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/login/components/drop_button_lang.dart';
import 'package:travelcars/screens/login/components/drop_button_mny.dart';
import 'package:travelcars/screens/login/login_srcreen.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * .98,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .4,
              child: SvgPicture.asset("assets/images/earth.svg"),
            ),
            Text(
              "Language:",
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            DropButton(),
            Text(
              "Currency:",
              style: TextStyle(
                fontSize: 21,
              ),
            ),
            DropButtonMny(),
            Spacer(),
            GestureDetector(
              onTap: () async {
                switch(DropButton.dropdawnvalue ){
                  case 'ENG' :
                    await context.setLocale(Locale('en'));
                    SplashScreen.til = "en";
                    break;
                  case 'RUS' :
                    await context.setLocale(Locale('ru'));
                    SplashScreen.til = "ru";
                    break;
                  case 'UZB' :
                    await context.setLocale(Locale('uz'));
                    SplashScreen.til = "uz";
                    break;
                }
                final prefs = await SharedPreferences.getInstance();
                prefs.setString(
                    "settings",
                    json.encode({
                      "locale": "${DropButton.dropdawnvalue}",
                      "currency": "${DropButtonMny.dropdawnvalue}",
                    })
                );
                SplashScreen.kurs = DropButtonMny.dropdawnvalue;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  ModalRoute.withName('/'),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.orange
                ),
                height: 40,
                width: MediaQuery.of(context).size.width * .75,
                child: Center(
                  child: Text(
                    "Подтвердить",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
