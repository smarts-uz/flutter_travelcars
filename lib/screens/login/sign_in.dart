import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/reset_password.dart';
import 'package:travelcars/screens/main_screen.dart';

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
            fontSize: 19,
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
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_)=>MainScreen()),
                      ModalRoute.withName('/'),
                    );
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
