import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool show = false;
  bool _obscureText = false;
  bool _obscureText1 = false;

  TextEditingController current_p = new TextEditingController();
  TextEditingController new_p = new TextEditingController();
  TextEditingController new_p_c = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text(
          LocaleKeys.change_password.tr(),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .1,
              left: 10,
              right: 10),
          height: MediaQuery.of(context).size.height * .9,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "${LocaleKeys.Current_password.tr()}",
                    labelStyle: TextStyle(
                      color: Colors.white10,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: show
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                  obscureText: show,
                  controller: current_p,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "${LocaleKeys.new_password.tr()}",
                    errorText: null,
                    labelStyle: TextStyle(
                      color: Colors.white10,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                  ),
                  obscureText: _obscureText,
                  controller: new_p,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "${LocaleKeys.New_password_confirmation.tr()}",
                    errorText: null,
                    labelStyle: TextStyle(
                      color: Colors.white10,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(_obscureText1
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                  ),
                  obscureText: _obscureText1,
                  controller: new_p_c,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String? current = prefs.getString("password");

                  if(current_p.text.compareTo(current!) != 0) {
                    ToastComponent.showDialog(LocaleKeys.You_entered.tr());
                    return;
                  }

                  if(new_p.text!.compareTo(new_p_c.text) != 0) {
                    ToastComponent.showDialog(LocaleKeys.You_entered_confirma.tr());
                    return;
                  }
                  Uri url = Uri.parse("${AppConfig.BASE_URL}/password/reset");
                  String token = jsonDecode(prefs.getString('userData')!)["token"];
                  final result = await http.post(
                      url,
                      headers: {
                        "Authorization": "Bearer $token",
                      },
                      body: {
                        "password" : new_p_c.text
                      }
                  );
                  print(jsonDecode(result.body));
                  prefs.setString("password", new_p_c.text);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.blue
                  ),
                  height: 40,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      LocaleKeys.save.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
