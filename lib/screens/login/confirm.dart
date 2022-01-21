import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/login/set_password.dart';
import 'package:travelcars/screens/login/social_network.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';
import '../../app_config.dart';

class Confirm extends StatefulWidget {
  final bool isSocial;
  final String password;
  int id;
  int code;

  Confirm(this.isSocial, this.id, this.code, {this.password = ""});

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  final TextEditingController _emailController = TextEditingController();
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
         LocaleKeys.Register_now.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 20,
          ),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.asset("assets/images/Mail1.png"),
              ),
              SizedBox(height: 15),
              Text(
                LocaleKeys.enter_mail_or_phone.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 25,
              ),
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
                    hintText: LocaleKeys.code.tr(),
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
                  controller: _emailController,
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
                  if(_emailController.text.isEmpty) {
                    ToastComponent.showDialog(LocaleKeys.TextField_is_empty.tr());
                    return;
                  }
                  String url = "${AppConfig.BASE_URL}/verify";
                  final result = await http.post(
                      Uri.parse(url),
                      body: {
                        'user_id': widget.id.toString(),
                        'code': '${_emailController.text}',
                      }
                  );

                  final response = json.decode(result.body)['data'];
                  if(json.decode(result.body)['success']){
                    final prefs = await SharedPreferences.getInstance();
                    if(widget.isSocial) await prefs.setString("password", widget.password);
                    final userData = json.encode({
                      'token': response['token']["access_token"],
                      'expiry_at': response['token']["expires_at"],
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => widget.isSocial ? SocialScreen() : SetPassword()
                        )
                    );
                  }
                  else
                    {
                      ToastComponent.showDialog(LocaleKeys.Code_is_wrong.tr());
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
                      LocaleKeys.confirm.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
