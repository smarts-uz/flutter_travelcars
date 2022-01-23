import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';


class TransfersInfo extends StatelessWidget {
  Map<String, dynamic> info;
  final String status;

  TransfersInfo(@required this.info, this.status);

  @override
  Widget build(BuildContext context) {
    double app_kurs = 1;
    double summa = 0;
    HomeScreen.kurs.forEach((element) {
      if(SplashScreen.kurs == element["code"]) {
        app_kurs = element["rate"].toDouble();
      }
    });
    if(info["price"] != null) {
      summa = app_kurs * info["price"].toDouble();
    }

    List<int> indexes = [];
    for(int i = 0; i<info["places"].length; i++) {
      indexes.add(i);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${LocaleKeys.application.tr()} #${info['id']}",
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
            Container(
                padding: EdgeInsets.only(top: 16),
                height: info["places"].length * 170.0,
                child: ListView.builder(
                    itemCount: info["places"].length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            '${info["places"][index]['type'] == "meeting" ? LocaleKeys.meeting.tr() : LocaleKeys.Drop_of.tr()}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24, top: 6),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontSize: 17
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${info["places"][index]['city']} ',
                                    style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                TextSpan(text: '(${info["places"][index]['date'].substring(0, 10)}, '),
                                TextSpan(text: '${info["places"][index]['time']})\n'),
                                TextSpan(
                                    text: '${LocaleKeys.Passengers.tr()}: ',
                                    style: TextStyle(fontWeight: FontWeight.bold,)
                                ),
                                TextSpan(text: '${info["places"][index]['passengers']}\n'),
                                TextSpan(
                                    text: '${LocaleKeys.Where_to_pick_up.tr()}: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                TextSpan(text: '${info["places"][index]['from']}\n'),
                                TextSpan(
                                    text: '${LocaleKeys.where.tr()}: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                TextSpan(
                                    text: '${info["places"][index]['to']}\n'
                                ),
                                TextSpan(
                                    text: '${LocaleKeys.note.tr()}: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                TextSpan(
                                    text: '${info["places"][index]['additional']}'
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                )
            ),
            /*Container(
              padding: EdgeInsets.only(top: 12),
              child: Column(
                children: indexes.map((index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 6),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontSize: 17
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${info["places"][index]['type'] == "meeting" ? LocaleKeys.meeting.tr() : LocaleKeys.Drop_of.tr()}\n',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange
                              ),
                            ),
                            TextSpan(
                                text: '\t\t${info["places"][index]['city']} ',
                                style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            TextSpan(text: '(${info["places"][index]['date'].substring(0, 10)}, '),
                            TextSpan(text: '${info["places"][index]['time']})\n'),
                            TextSpan(
                                text: '\t\t${LocaleKeys.Passengers.tr()}: ',
                                style: TextStyle(fontWeight: FontWeight.bold,)
                            ),
                            TextSpan(text: '${info["places"][index]['passengers']}\n'),
                            TextSpan(
                                text: '\t\t${LocaleKeys.Where_to_pick_up.tr()}: ',
                                style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            TextSpan(text: '${info["places"][index]['from']}\n'),
                            TextSpan(
                                text: '\t\t${LocaleKeys.where.tr()}: ',
                                style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                                text: '${info["places"][index]['to']}\n'
                            ),
                            TextSpan(
                                text: '\t\t${LocaleKeys.note.tr()}: ',
                                style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                                text: '${info["places"][index]['additional']}'
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )).toList(),
              ),
            ),*/
            Padding(
              padding: EdgeInsets.only(left: 16, top: 10),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        height: 1.5
                    ),
                    children: [
                      TextSpan(
                          text: '${LocaleKeys.Auto_types.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['car_model'] != null ? info['car_model']['name'] : ""}\n'),
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
                padding: EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  LocaleKeys.contact.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 5),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
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
