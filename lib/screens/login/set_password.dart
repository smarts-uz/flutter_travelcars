import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';
import '../../app_config.dart';
import 'components/toast.dart';

class SetPassword extends StatefulWidget {

  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final TextEditingController _newPasswordController = TextEditingController();
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
            size: 28,
          ),
        ),
        title: Text(
          "Сброс пароля",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Создайте новый пароль",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 45,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  obscureText: show,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    hintText: "Пароль",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: show ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
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
                  autofocus: false,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  obscureText: show,
                  autovalidateMode: AutovalidateMode.always,
                  decoration:  InputDecoration(
                    hintText: "Подтверждение пароля",
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
                  controller: _newPasswordController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 19),
                  expands: false,
                  maxLines: 1,
                  autofocus: false,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String url = "${AppConfig.BASE_URL}/password/reset";
                  String token = json.decode(prefs.getString('userData')!)["token"];

                  if(_newPasswordController.text == _passwordController.text){
                    try{
                      final result = await http.post(
                        Uri.parse(url),
                        body: {
                          'password': _newPasswordController.text
                        },
                        headers: {
                          "Authorization": "Bearer $token",
                        },
                      );
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString("password", _newPasswordController.text);
                    }
                    catch(error){
                      print(error);
                      Dialogs.ErrorDialog(context);
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_)=> MainScreen()
                      ),
                      ModalRoute.withName('/'),
                    );
                  }
                  else
                    {
                      ToastComponent.showDialog(LocaleKeys.Passwords_should_be_same.tr());
                    }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.orange
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width * .75,
                  child: Center(
                    child: Text(
                      "Завершить",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
