import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/login/set_password.dart';
import 'package:travelcars/screens/login/social_network.dart';
import 'package:http/http.dart' as http;
import '../../app_config.dart';

class Confirm extends StatefulWidget {
  final bool isSocial;
  int id;
  int code;

  Confirm(this.isSocial, this.id,this.code);

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
            size: 28,
          ),
        ),
        title: Text(
          "Регистрация",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.89,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  height: 192,
                  child: Image.asset("assets/images/Mail1.png"),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Введите код подтверждения, которую мы\nотправили вам на электронную почту или на\nтелефон",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 15,
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
                    obscureText: show,
                    autovalidateMode: AutovalidateMode.always,
                    decoration:  InputDecoration(
                      hintText: "Код",
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
                    style: TextStyle(fontSize: 20),
                    expands: false,
                    maxLines: 1,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    String url = "${AppConfig.BASE_URL}/verify";
                    final result = await http.post(
                        Uri.parse(url),
                        body: {
                        'user_id': widget.id.toString(),
                          'code': widget.code.toString(),
                        }
                    );

                    final Map<String, dynamic> response = json.decode(result.body);
                    if(response["success"]){

                      final prefs = await SharedPreferences.getInstance();
                      final userData = json.encode({
                        'token': response["accessToken"],

                      });
                      await prefs.setString('userData', userData);
                      Navigator.push(context,MaterialPageRoute(builder: (_) =>
                      widget.isSocial ? SocialScreen() : SetPassword()));
                    }
                    else
                      {
                        ToastComponent.showDialog('Code is wrong !');
                      }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.orange
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        "Подтвердить",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
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
