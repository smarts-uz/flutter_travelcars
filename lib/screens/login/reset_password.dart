import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelcars/screens/login/confirm.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/login/set_password.dart';
import '../../app_config.dart';

class ResetPassword extends StatefulWidget {


  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final TextEditingController _emailController = TextEditingController();
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
            size: 28
          ),
        ),
        title: Text(
          "Восстановить пароль",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 20),
              Text(
                "Введите электронную почту или номер\n телефона, и мы отправим код для сброса пароля ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 30,
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
                  decoration: const InputDecoration(
                    hintText: "Phone(998) or e-mail",
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
              Spacer(),
              GestureDetector(
                onTap: () async {
                  String url = "${AppConfig.BASE_URL}/password/forgot";
                  final result = await http.post(
                      Uri.parse(url),
                      body: {
                        'email':'${_emailController.text}'
                      }
                  );
                  print(result.body);
                  int id = json.decode(result.body)["user_id"];
                  int code = json.decode(result.body)['code'];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>Confirm( false,id,code)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.orange
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width * .35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Далее",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_ios,color: Colors.white,)
                    ],
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
