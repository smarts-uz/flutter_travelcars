import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/login/reset_password.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          LocaleKeys.entered.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .9,
          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 20,),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5),
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width * .8,
                child: SvgPicture.asset("assets/images/mobile.svg"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  decoration:  InputDecoration(
                    hintText: LocaleKeys.Phone.tr(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 19),
                  expands: false,
                  maxLines: 1,
                  autofocus: false,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.only(left: 15),
               // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  obscureText: show,
                  autovalidateMode: AutovalidateMode.always,
                  decoration:  InputDecoration(
                    hintText: "${LocaleKeys.password.tr()}",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: !show ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0,
                      ),
                    ),
                  ),
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 19),
                  expands: false,
                  maxLines: 1,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    ToastComponent.showDialog(LocaleKeys.TextField_is_empty.tr());
                    return;
                  }

                  if(_emailController.text.substring(0, 1) == "+") {
                    _emailController.text = _emailController.text.substring(1, _emailController.text.length -1);
                  }

                  String url = "${AppConfig.BASE_URL}/login";
                  final result = await http.post(
                    Uri.parse(url),
                    body: {
                      'username': "${_emailController.text}",
                      'password': "${_passwordController.text}",
                    }
                  );
                  final Map<String, dynamic> response = json.decode(result.body);

                  final prefs = await SharedPreferences.getInstance();
                  print(_passwordController.text);
                  await prefs.setString("password", _passwordController.text);
                  if(response["accessToken"] != null) {
                    final userData = json.encode({
                      'token': response["accessToken"],
                      'expiry_at': response["expires_at"],
                      'user_id': response["user"]["id"],
                      'email': response["user"]["email"],
                      'name': response["user"]["name"],
                      'phone': response["user"]["phone"],
                      'socials': response["user"]["socials"],
                      "shaxs": response["user"]["personality"],
                      "cashback_summa": response["user"]["cashback_money"],
                      "cashback_foiz": response["user"]["cashback_percent"],
                    });
                    await prefs.setString('userData', userData);
                    if(response["company"] != null && response["company"].isNotEmpty) {
                      final api_data = response["company"][0];
                      final companyData = json.encode({
                        "name": api_data["company_name"],
                        "city": api_data["company_city"],
                        "address": api_data["company_address"],
                        "post": api_data["post_index"],
                        "bank": api_data["bank"],
                        "bank_account": api_data["bank_account"],
                        "oked": api_data["oked"],
                        "mfo": api_data["mfo"],
                        "inn": api_data["inn"],
                        "okonh": api_data["okonh"],
                      });
                      await prefs.setString("companyData", companyData);
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_)=> MainScreen()
                      ),
                      ModalRoute.withName('/'),
                    );
                  } else {
                    ToastComponent.showDialog("${response["errors"]}");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.orange
                  ),
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text(
                      LocaleKeys.entered.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (_)=>ResetPassword()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[50],
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                        ),
                      ]),
                  height: 40,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text(
                    LocaleKeys.Restore_password.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
