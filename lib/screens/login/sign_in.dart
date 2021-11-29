import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/reset_password.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:http/http.dart' as http;

import '../../app_theme.dart';

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
          ),
        ),
        title: Text(
          "Войти",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.89,
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 20,),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Container(
                  height: 208,
                  width: double.infinity,
                  child: SvgPicture.asset("assets/images/mobile.svg"),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  padding: EdgeInsets.only(left: 15),
                 // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                      hintText: "E-mail",
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
                    style: TextStyle(fontSize: 20),
                    expands: false,
                    maxLines: 1,
                    autofocus: false,
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  height: 55,
                  padding: EdgeInsets.only(left: 15),
                 // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    obscureText: show,
                    autovalidateMode: AutovalidateMode.always,
                    decoration:  InputDecoration(
                      hintText: "Пароль",
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
                    style: TextStyle(fontSize: 20),
                    expands: false,
                    maxLines: 1,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    String url = "${AppConfig.BASE_URL}/login";
                    final result = await http.post(
                      Uri.parse(url),
                      body: {
                        'username': "${_emailController.text}",
                        'password': "${_passwordController.text}",
                      }
                    );
                    final Map<String, dynamic> response = json.decode(result.body);
                    if(response["accessToken"] != null) {
                      final prefs = await SharedPreferences.getInstance();
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
                      if(response["company"] != null) {
                        final api_data = response["company"]["requisites"][0];
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
                      print("error");
                      print(response["errors"]);
                    }
                    },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.orange),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Войти",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ]),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Восстановить пароль",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColor.orange,
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
      ),
    );
  }
}
