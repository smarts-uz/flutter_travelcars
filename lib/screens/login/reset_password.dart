import 'package:flutter/material.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/set_password.dart';

import '../../app_theme.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

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
          ),
        ),
        title: Text(
          "Восстановить пароль",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 24,),
                Text(
                  "Введите электронную почту или номер\n телефона, и мы отправим код для сброса пароля ",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  padding: EdgeInsets.only(left: 15),
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
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>SetPassword()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MyColor.orange),
                        height: 40,
                        width: 154,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Далее",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward_ios,color: Colors.white,)
                          ],
                        ),
                      ),
                    ),
                  ],
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