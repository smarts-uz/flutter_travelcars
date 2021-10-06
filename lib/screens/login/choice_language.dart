import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/app_theme.dart';
import 'package:travelcars/screens/login/components/drop_button_lang.dart';
import 'package:travelcars/screens/login/components/drop_button_mny.dart';
import 'package:travelcars/screens/login/login_srcreen.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 98, bottom: 10, left: 16, right: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 360,
                child: SvgPicture.asset("assets/images/earth.svg"),
              ),
              DropButton(),
              DropButtonMny(),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (_)=>LoginScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: MyColor.orange),
                  height: 40,
                  width: 312,
                  child: Center(
                    child: Text(
                      "Подтвердить",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white,

                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
