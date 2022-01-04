import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/login/components/drop_button_lang.dart';
import 'package:travelcars/screens/login/components/drop_button_mny.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';


class AccountChoicePage extends StatefulWidget {
  const AccountChoicePage({Key? key}) : super(key: key);

  @override
  _AccountChoicePageState createState() => _AccountChoicePageState();
}

class _AccountChoicePageState extends State<AccountChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text(
          "Настройка языка и курса",
          style: TextStyle(
              color: Colors.white,
              fontSize: 23
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 17, top: 2, right: 17),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              Text(
                "Language:",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              DropButton(),
              SizedBox(height: 20),
              Text(
                "Currency:",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              DropButtonMny(),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  switch(DropButton.dropdawnvalue ){
                    case 'ENG' :  await context.setLocale(Locale('en'));
                    break;
                    case 'RUS' :  await context.setLocale(Locale('ru'));
                    break;
                    case 'UZB' :  await context.setLocale(Locale('uz'));
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_)=> SplashScreen()
                    ),
                    ModalRoute.withName('/'),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blue),
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Сохранить",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,

                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ]),
      ),
    );
  }
}
