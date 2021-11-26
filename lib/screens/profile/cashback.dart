import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CashbackScreen extends StatefulWidget {
  @override
  _CashbackScreenState createState() => _CashbackScreenState();
}

class _CashbackScreenState extends State<CashbackScreen> {
  Map<String , dynamic> info = {
    "summa": 0,
    "foiz": 0,
  };


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      Map<String, dynamic> userinfo = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      info["summa"] = userinfo["cashback_summa"];
      info["foiz"] = userinfo["cashback_foiz"];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Кешбэк",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 19,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            icon: SvgPicture.asset("assets/Vector.svg"),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/Group 278.svg",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Row(
                children: [
                  Text("Вам назначен процент в размере:"),
                ],
              ),
            ),
            Container(
              height: 85,
              width: 328,
              alignment: Alignment.center,
              color: Color.fromRGBO(255, 245, 228, 1),
              child: Text(
                "${info["foiz"]}%",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 46),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Row(children: [
                Text(
                  "Вам начислен кэшбек в размере:",
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            Container(
              height: 85,
              width: 328,
              alignment: Alignment.center,
              color: Color.fromRGBO(255, 245, 228, 1),
              child: Text(
                "${info["summa"]} UZS",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 46),
              ),
            ),
          ],
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
            height: 350,
            padding: EdgeInsets.only(bottom: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 32, top: 32),
                    child: Text(
                      "О Кешбэке",
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15),
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(223, 223, 223, 1),
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18, top: 16),
                          child: Text(
                            "Кэшбэк - это возврат средств.",
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                fontStyle: FontStyle.normal,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Text(
                            "В случае оплаты через платежные системы (Click и Payme) и международные карты (Visa, Master Card) Вам начисляется кэшбэк до 5%* от общий суммы платежа.",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Text(
                            "Начисленный кэшбэк выплачивается на счет клиента (на личную банковскую карту) в сумах ежемесячно с 5-го по 10-е число месяца.  ",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Text(
                            "* Размер процента зависит от активности бронирований через наш веб-сайт или моб. приложения.",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
