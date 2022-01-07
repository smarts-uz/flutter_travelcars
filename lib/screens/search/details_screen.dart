import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/profile/reviews.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';

import '../../app_config.dart';


class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> route_item;

  DetailScreen(this.route_item);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {

  final CarouselController _controller = CarouselController();
  int _current = 0;
  int narx_index = 0;
  late String dropdown;
  List<dynamic> narxlar = [];

  void _otmen(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.3,
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Условия отмены',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
              Divider(),
              Text(
                '${widget.route_item["company"]["refund"]}',
                maxLines: 12,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _inform(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.15,
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Важная информация',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent
                ),
              ),
              Divider(),
              Text(
                '${widget.route_item["company"]["important"]}',
                textAlign: TextAlign.justify,
                maxLines: 5,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent
                ),
              )
            ],
          ),
        );
      },
    );
  }

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
    jsonDecode(widget.route_item["price_data"]).forEach((key, value) {
      if(value != null) {
        double cost;
        if(value.runtimeType == String) {
          cost = double.parse(value) * app_kurs;
        } else {
          cost = value * app_kurs;
        }
        narxlar.add({
          "day": "$key day",
          "cost": "${cost.round()} ${SplashScreen.kurs}"
        });
      }
    });
    dropdown = narxlar[0]["day"];
    print(narxlar);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> results = widget.route_item;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24),
                  height: 330,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: false,
                        disableCenter: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                    items: results["car"]["images"].map<Widget>((item) {
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 30,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
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
                    children: results["car"]["images"].asMap().entries.map<Widget>((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4)
                            )
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            _text(text: results["car"]["title"]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 3),
                  child: Text(
                    "Год выпуска: ${results["car"]["year"]}\nID номер: ${results["car"]["uid"]}",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 18, left: 5),
                      child: Text(
                        "${results["car"]["views"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            _listWrap(results["car"]['car_options']),
            if(results["route_options"].isNotEmpty) Container(
              decoration: BoxDecoration(color: HexColor("#F5F5F6")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 10, bottom: 0),
                    child: Text(
                      "В тарифе включено: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: results["route_options"].length * 35.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: HexColor("#F5F5F6")),
                    padding: EdgeInsets.only(bottom: 8, left: 16),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: results["route_options"].length,
                      itemExtent: 28,
                      itemBuilder: (context, i) => Row(
                        children: [
                          Icon(Icons.check, color: Colors.green),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            results["route_options"][i]["name"],
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //_text(text: "Карта поездки"),
            /*Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/map.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MapScreen()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.orange,
                      ),
                      child: Center(
                        child: Text(
                          "Посмотреть маршрут",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),*/
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
            Container(
              padding: EdgeInsets.only(left: 16),
              child: TextButton(
                onPressed: () {
                  _otmen(context);
                },
                child: Text(
                  "Условия отмены",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, bottom: 5),
              child: TextButton(
                onPressed: () {
                  _inform(context);
                },
                child: Text(
                  "Важная информация",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                if(prefs.containsKey("userData")) {
                  String token = json.decode(prefs.getString('userData')!)["token"];
                  Uri url = Uri.parse("${AppConfig.BASE_URL}/book/create");
                  print(jsonEncode({
                    "route_price_id": "${results["route_price_id"]}",
                    "cost": "${results["cost"]}",
                    "price": "${results["price"]}",
                  }));
                  final response = await http.post(
                      url,
                      headers: {
                        "Authorization": "Bearer $token"
                      },
                      body: {
                        "route_price_id": "${results["route_price_id"]}",
                        "cost": "${results["cost"]}",
                        "price": "${results["price"]}",
                      }
                  );
                  try{
                    if(jsonDecode(response.body)["success"]) {
                      Dialogs.ZayavkaDialog(context);
                    } else {
                      Dialogs.ErrorDialog(context);
                    }
                  } catch(error) {
                    print(error);
                    Dialogs.ErrorDialog(context);
                  }
                } else {
                  Dialogs.LoginDialog(context);
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                alignment: Alignment.center,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    "Бронировать",
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
        ),
      ),
    );
  }

  Widget _text({text}) {
    return Container(
      padding: EdgeInsets.only(left: 15, bottom: 10, top: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
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
      height: wrap.length * 30,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: wrap.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 50,
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
