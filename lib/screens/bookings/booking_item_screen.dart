import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/profile/reviews.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_config.dart';


class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> book_item;
  BookingScreen(this.book_item);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<Map<String, dynamic>> payments = [
    {
      "icon": "click",
      "name": "Click",
      "chosen": true,
    },
    {
      "icon": "payme",
      "name": "Payme",
      "chosen": false,
    },
    {
      "icon": "mastercard",
      "name": "MasterCard",
      "chosen": false,
    },
    {
      "icon": "visa",
      "name": "Visa",
      "chosen": false,
    },
  ];


  final CarouselController _controller = CarouselController();
  int current = 0;
  int narx_index = 0;
  late String dropdown;
  List<dynamic> narxlar = [];

  bool agree = false;

  @override
  void initState() {
    super.initState();
    double app_kurs = 1;
    switch(SplashScreen.kurs) {
      case "UZS":
        app_kurs = HomeScreen.kurs[0];
        break;
      case "EUR":
        app_kurs = HomeScreen.kurs[0]/HomeScreen.kurs[1];
        break;
      case "RUB":
        app_kurs = HomeScreen.kurs[0]/HomeScreen.kurs[2];
        break;
    }

    jsonDecode(widget.book_item["route"]["cost_data"]).forEach((key, value) {
      if(value != null) {
        double cost;
        if(value.runtimeType == String) {
          cost = double.parse(value) * app_kurs;
        } else {
          cost = value * app_kurs;
        }
        narxlar.add({
          "day": "$key day",
          "cost": "${cost.toStringAsFixed(2)} ${SplashScreen.kurs}"
        });
      }
    });
    dropdown = narxlar[0]["day"];
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> results = widget.book_item;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Booking #${results["id"]}",
          style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  height: 270,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: false,
                        disableCenter: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                        }
                    ),
                    items: results["images"].map<Widget>((item) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "${AppConfig.image_url}/cars/${item["original"]}",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)
                          ),
                        ),
                      );
                    }
                    ).toList(),
                  ),
                ),
                Positioned(
                  right: 25,
                  bottom: -25,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Reviews(route_price_id: results["route_price_id"],)
                          )
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 30,
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: results["images"].asMap().entries.map<Widget>((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(current == entry.key ? 0.9 : 0.4)
                            )
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            _text(text: results["car"]["title"]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      child: Text(
                        "Статус:",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      child: Text(
                        "${results["status"]}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,top: 8, bottom: 5,),
                  child: Text(
                    "${results["route"]["title"]}",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, bottom: 5),
                      child: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, bottom: 3),
                      child: Text(
                        "${results["date"].substring(0,10)}",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _listWrap(results['carOption']),
            if(results["routeOption"].isNotEmpty) Container(
              decoration: BoxDecoration(color: HexColor("#F5F5F6")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 10, bottom: 5.0),
                    child: Text(
                      "В тарифе включено:",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: results["routeOption"].length * 33.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: HexColor("#F5F5F6")),
                    padding: EdgeInsets.only(left: 16),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: results["routeOption"].length,
                      itemBuilder: (context, i) => Container(
                        height: 30,
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              results["routeOption"][i]["name"],
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _text(text: "Стоимость поездки за"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 16,right: 16),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                          ),
                        ]),
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        child: DropdownButton<String>(
                          hint: Text("Страна"),
                          dropdownColor: Colors.grey[50],
                          icon: Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          underline: SizedBox(),
                          value: dropdown,
                          onChanged: (newValue) {
                            int newIndex = 0;
                            narxlar.forEach((element) {
                              if(element["day"] == newValue) {
                                setState(() {
                                  dropdown = newValue!;
                                  narx_index = newIndex;
                                });
                              }
                              newIndex++;
                            });

                          },
                          items: narxlar.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['day'],
                              child: Text(
                                value['day'],
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                  color: HexColor('#3C3C43'),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(left: 16,right: 16 ),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ]),
                      child: Center(
                        child: Text(
                          narxlar[narx_index]["cost"],
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: HexColor('#3C3C43'),
                          ),
                        ),
                      )
                  ),
                )
              ],
            ),
            results["status"] == "accepted" && results["paid"] == null ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(text: "Выберите способ оплаты:"),
                SizedBox(
                  height: 270,
                  child: ListView.builder(
                    itemCount: payments.length,
                    itemExtent: 65,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap:() {
                          payments.forEach((element) {
                            element["chosen"] = false;
                          });
                          payments[index]["chosen"] = true;
                          setState(() {

                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          height: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: payments[index]["chosen"] ? Colors.green : Colors.grey[100],
                              border: Border.all(color: Colors.grey),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                ),
                              ]),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 45,
                                child: Image.asset("assets/icons/${payments[index]["icon"]}.png"),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Center(
                                child: Text(
                                  payments[index]["name"],
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 17,
                                    color: HexColor('#3C3C43'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: agree,
                        onChanged: (value) {
                          setState(() {
                            agree = value!;
                          });
                        }),
                    Container(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Я ознакомлен и согласен с ',
                                style: new TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Политикой\nконфиденциальности ',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch("https://travelcars.uz/rules");
                                  },
                              ),
                              TextSpan(
                                text: 'и',
                                style: new TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: ' Публичной офертой',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch("https://travelcars.uz/publicrules");
                                  },
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if(!agree) {
                      ToastComponent.showDialog(LocaleKeys.Please_agree.tr());
                      return;
                    }
                    String type = "click";
                    payments.forEach((element) {
                      if(element["chosen"]) {
                        type = element["icon"];
                      }
                    });

                    int id = results["id"];
                    int amount = int.parse(results["price"]) * (HomeScreen.kurs[0]).toInt();
                    switch(type) {
                      case "click":
                        launch("https://my.click.uz/services/pay?service_id=13729&merchant_id=9367&amount=$amount&transaction_param=$id&return_url=https://travelcars.uz/bookings/show/299&card_type=uzcard");
                        break;
                      case "payme":
                        String data = "m=5cd1820b1722d50474387f3a;ac.booking_id=$id;a=$amount";
                        var bytes = utf8.encode(data);
                        var base64 = base64Encode(bytes);
                        launch("https://checkout.paycom.uz/$base64");
                        break;
                      case "mastercard":
                        launch("https://travelcars.uz/octo/$id/mCard");
                        break;
                      case "visa":
                        launch("https://travelcars.uz/octo/$id/Visa");
                        break;
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        "Оплатить",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _text({text}) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 10, top: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 23,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  Widget _listWrap(List wrap) {
    return Container(
      height: wrap.length * 25,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: wrap.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 45,
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * 0.43,
            child: Chip(
              backgroundColor: Colors.transparent,
              avatar: SvgPicture.asset("assets/icons/globus.svg"),
              label: Text(
                wrap[index]["name"],
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
