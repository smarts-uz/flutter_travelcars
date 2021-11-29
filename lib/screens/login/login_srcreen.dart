import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/app_theme.dart';
import 'package:travelcars/screens/login/sign_in.dart';
import 'package:travelcars/screens/login/sing_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          "Авторизация",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 20),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                Container(
                  height: 182,
                  width: double.infinity,
                  child: SvgPicture.asset("assets/images/way.svg"),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Войдите или зарегестрируйтесь чтобы\n продолжить",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontFamily: "Poppins"),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SignIn()));
                  },
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
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp()));
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
                    width: 312,
                    child: Center(
                      child: Text(
                        "Зарегестрироваться",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColor.orange,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
