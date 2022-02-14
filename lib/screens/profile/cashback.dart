import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';


class CashbackScreen extends StatefulWidget {
  @override
  _CashbackScreenState createState() => _CashbackScreenState();
}

class _CashbackScreenState extends State<CashbackScreen> {
  bool isLoading = true;
  double summa = 0;
  Map<String, dynamic> info = {};


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString('userData')!)["token"];
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getCashback");
    final result = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        }
    );
    info = jsonDecode(result.body)["data"];
    double app_kurs = 1;
    HomeScreen.kurs.forEach((element) {
      if(SplashScreen.kurs == element["code"]) {
        app_kurs = element["rate"].toDouble();
      }
    });

    summa = app_kurs * double.parse(info["cashback_money"]);

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
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
          LocaleKeys.cashback.tr(),
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            icon: SvgPicture.asset(
              "assets/Vector.svg",
            ),
            iconSize: 40,
          ),
        ],
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/Group 278.svg",
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "${LocaleKeys.You_have_been_assigned_percentage_of.tr()}:",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                height: 85,
                width: MediaQuery.of(context).size.width * .8,
                alignment: Alignment.center,
                color: Color.fromRGBO(255, 245, 228, 1),
                child: FittedBox(
                  child: Text(
                    "${info["cashback_percent"]} %",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 46),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "${LocaleKeys.You_have_received_cashback_in_the_amount_of.tr()}: ",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                height: 85,
                width: MediaQuery.of(context).size.width * .8,
                alignment: Alignment.center,
                color: Color.fromRGBO(255, 245, 228, 1),
                child: FittedBox(
                  child: Text(
                    "${summa.toStringAsFixed(2)} ${SplashScreen.kurs}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 46),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            height: 360,
            padding: EdgeInsets.only(left: 17, right: 17, top: 17, bottom: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.aboute_cashback.tr(),
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15),
                  ),
                  Divider(
                    color: Color.fromRGBO(223, 223, 223, 1),
                    height: 16,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                      ),
                      children: [
                        TextSpan(text: "${LocaleKeys.cashback1.tr()}\n\n",),
                        TextSpan(text: LocaleKeys.cashback2.tr(), style: TextStyle(fontStyle: FontStyle.italic))
                      ]
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
