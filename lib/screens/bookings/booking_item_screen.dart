import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_config.dart';


class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> book_item;
  BookingScreen(this.book_item);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final CarouselController _controller = CarouselController();
  int current = 0;
  int narx_index = 0;
  late String dropdown;
  List<dynamic> narxlar = [];

  bool agree = false;

  @override
  void initState() {
    super.initState();
    jsonDecode(widget.book_item["route"]["cost_data"]).forEach((key, value) {
      if(value != null) {
        int cost;
        if(value.runtimeType == String) {
          cost = (double.parse(value) * HomeScreen.kurs_dollar).toInt();
        } else {
          cost = (value * HomeScreen.kurs_dollar).toInt();
        }
        narxlar.add({
          "day": "$key day",
          "cost": "$cost UZS"
        });
      }
    });
    dropdown = narxlar[0]["day"];
    print(narxlar);
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
                        "${results["route"]["created_at"].substring(0,10)}",
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
            Container(
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
            results["status"] == "accepted" ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(text: "Выберите способ оплаты:"),
                GestureDetector(
                  onTap: (){
                    // TODO: implement payment api
                    //_launchApp('https://click.uz');
                  },
                  child: _payment(icon: "assets/icons/Click1.png", name: "Click"),),
                GestureDetector(
                  onTap:() {
                    //_launchApp('https://payme.uz/');
                  },
                    child: _payment(icon: "assets/icons/online_payme.png", name: "Payme")),
                GestureDetector(
                  onTap: (){
                    //_launchApp('https://www.mastercard.us/');
                  },
                    child: _payment(icon: "assets/icons/mastercard-2.png", name: "MasterCard")),
                GestureDetector(
                  onTap: (){
                    //_launchApp('https://cis.visa.com/ru_TJ/visa-in-uzbekistan.html');
                  },
                    child: _payment(icon: "assets/icons/visa 1.png", name: "Visa")),
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
                    // TODO: implement payment press api
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

  Widget _payment({icon, name}) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
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
      child: Row(
        children: [
          Container(
            height: 24,
            width: 40,
            child: Image.asset(icon),
          ),
          SizedBox(
            width: 15,
          ),
          Center(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 15,
                color: HexColor('#3C3C43'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
