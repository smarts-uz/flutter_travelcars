import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_theme.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          height: MediaQuery.of(context).size.height*0.9,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
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
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.only(left: 15),
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        hintText: "Пароль",
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
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: MyColor.orange),
                      height: 40,
                      width: 312,
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
                    onTap: () {},
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
                      width: 312,
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
      ),
    );
  }
}
