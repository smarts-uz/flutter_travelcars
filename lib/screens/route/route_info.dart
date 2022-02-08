import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
class RouteInfo extends StatelessWidget {
  Map<String, dynamic> info;
  final String status;

  RouteInfo(@required this.info, this.status);

  Widget build(BuildContext context) {
    double app_kurs = 1;
    double summa = 0;
    List<int> indexes = [];

    HomeScreen.kurs.forEach((element) {
      if(SplashScreen.kurs == element["code"]) {
        app_kurs = element["rate"].toDouble();
      }
    });
    if(info["price"] != null) {
      summa = app_kurs * info["price"].toDouble();
    }

    for(int i = 0; i < info["routes"].length; i++) {
      indexes.add(i);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${LocaleKeys.application.tr()} #${info['id']}",
          maxLines: 2,
          style: TextStyle(
              color: Colors.white,
              fontSize: 23
          ),
        ),
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
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                children: indexes.map((index) => Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 15),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontSize: 17
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${info["routes"][index]['from']} - ${info["routes"][index]['to']}  ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '(${info["routes"][index]['date'].substring(0, 10)})\n'),
                        TextSpan(
                            text: '${LocaleKeys.Passengers.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold,)),
                        TextSpan(text: '${info["routes"][index]['passengers']}\n'),
                        TextSpan(
                            text: '${LocaleKeys.Where_to_pick_up.tr()}: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${info["routes"][index]['address']}'),
                      ],),
                  ),
                )).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        height: 1.6
                    ),
                    children: [
                      TextSpan(
                          text: '${LocaleKeys.Auto_types.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['car_type'] != null ? info['car_type']["name"] : ""}\n'),
                      if(info['additional'] != null) TextSpan(
                          text: '${LocaleKeys.additional.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      if(info['additional'] != null) TextSpan(text: '${info['additional']}\n'),
                      if(info['price'] != null && info['price'] != 0) TextSpan(
                          text: '${LocaleKeys.pricing.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      if(info['price'] != null && info['price'] != 0) TextSpan(text: '${summa.toStringAsFixed(2)} ${SplashScreen.kurs}\n'),
                      TextSpan(
                          text: '${LocaleKeys.status.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: status)
                    ]
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "${LocaleKeys.contact.tr()}: ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      height: 1.6,
                    ),
                    children: [
                      TextSpan(
                          text: '${LocaleKeys.name.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_name']}\n'),
                      TextSpan(
                          text: '${LocaleKeys.phone.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_phone']}\n'),
                      TextSpan(
                          text: 'E-mail: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_email']}\n'),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
