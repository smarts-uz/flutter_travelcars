import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/login/components/drop_button_lang.dart';
import 'package:travelcars/screens/login/components/drop_button_mny.dart';
import 'package:travelcars/screens/search/search.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';


class AccountChoicePage extends StatefulWidget {
  const AccountChoicePage({Key? key}) : super(key: key);

  @override
  _AccountChoicePageState createState() => _AccountChoicePageState();
}

class _AccountChoicePageState extends State<AccountChoicePage> {
  bool testServer = AppConfig.url == "http://userapp.travelcars.teampro.uz" ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text(
          LocaleKeys.Setting_the_language_and_course.tr(),
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
                "${LocaleKeys.language.tr()}:",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              DropButton(),
              SizedBox(height: 20),
              Text(
                "${LocaleKeys.Currency.tr()}:",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              DropButtonMny(),
              Row(
                children: [
                  Checkbox(
                    onChanged: (bool? value) {
                      if(!testServer) {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              content: Container(
                                height: 70,
                                width: MediaQuery.of(context).size.width * .85,
                                child: Column(
                                  children: [
                                    Text(
                                      LocaleKeys.test_server.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                FlatButton(
                                  child: Text(
                                    LocaleKeys.yes.tr(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      testServer = true;
                                    });
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    LocaleKeys.no.tr(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.green
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        setState(() {
                          testServer = false;
                        });
                      }
                    },
                    value: testServer,
                  ),
                  SizedBox(width: 5),
                  Text(
                    LocaleKeys.Turn_on_test_server.tr(),
                    style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ],
              ),
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

                  SearchScreen.SelectedVal1 = null;
                  SearchScreen.SelectedVal2 = null;

                  if(testServer) {
                    AppConfig.url = "http://userapp.travelcars.teampro.uz";
                  } else {
                    AppConfig.url = "http://userapp.travelcars.uz";
                  }
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
                      LocaleKeys.save.tr(),
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
