import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/login/choice_language.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatorHome();
  }
  
  _navigatorHome() async{
    await Future.delayed(Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>ChoicePage()));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       // height: MediaQuery.of(context).size.height*0.9,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30,top: 192),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 194,
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                Container(
                  child: Text(
                    "2018 - 2021 Travel Cars\n Все права защищены",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
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