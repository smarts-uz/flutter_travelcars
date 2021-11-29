import 'package:flutter/material.dart';
import 'package:travelcars/screens/login/set_password.dart';
import 'package:travelcars/screens/login/social_network.dart';
import '../../app_theme.dart';

class Confirm extends StatefulWidget {
  final bool isSocial;

  Confirm(@required this.isSocial);

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
          ),
        ),
        title: Text(
          "Регистрация",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
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
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (_) =>
                        widget.isSocial ? SocialScreen() : SetPassword()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.orange),
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
