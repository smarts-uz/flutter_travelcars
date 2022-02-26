import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/profile/reviews.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_config.dart';


class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> book_item;
  String route_name;
  BookingScreen(this.book_item, this.route_name);

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
      "icon": "visa",
      "name": "Visa",
      "chosen": false,
    },
    {
      "icon": "mastercard",
      "name": "MasterCard",
      "chosen": false,
    },
  ];


  final CarouselController _controller = CarouselController();
  int current = 0;
  int narx_index = 0;
  late String dropdown;
  late String day;
  List<dynamic> narxlar = [];

  bool agree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> results = widget.book_item;
    String status = "Unknown";
    switch(results['status']) {
      case "moderating":
        status = LocaleKeys.route_one_on_consideration.tr();
        break;
      case "proceed":
        status = LocaleKeys.pending.tr();
        break;
      case "rejected":
        status = LocaleKeys.rejected.tr();
        break;
      case "accepted":
        status = LocaleKeys.approved.tr();
        break;
    }

    List<int> carOptions = [];
    for(int i = 0; i < results['carOption'].length; i++) {
      carOptions.add(i);
    }

    List<int> routeOptions = [];
    for(int i = 0; i < results["routeOption"].length; i++) {
      routeOptions.add(i);
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.orange,
        title: Text(
          "${LocaleKeys.booking.tr()} #${results["id"]}",
          maxLines: 2,
          style: TextStyle(
            fontSize: 23,
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
            size: 25,
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
                              onError: (error, stackTrace) {
                                Image.asset(
                                  "assets/images/no_image.png",
                                  fit: BoxFit.cover,
                                );
                              }
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
                        "${LocaleKeys.status.tr()}: $status",
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
                Container(
                  padding: EdgeInsets.only(left: 16,top: 8, bottom: 5,),
                  child: Text(
                    "${widget.route_name}",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: Column(
                children: carOptions.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      results['carOption'][e]["image"] == null ? Image.asset(
                        "assets/images/no_image.jpg",
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ) : Image.network(
                        "${AppConfig.image_url}/car-options/${results['carOption'][e]["image"]}",
                        width: 25,
                        height: 25,
                        errorBuilder: (context, error, stackTrace) {
                          print(error);
                          return Image.asset(
                            "assets/images/no_image.png",
                            width: 25,
                            height: 25,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          results['carOption'][e]["name"],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            if(results["routeOption"].isNotEmpty) Container(
              margin: EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(color: HexColor("#F5F5F6")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 10, bottom: 5.0),
                    child: Text(
                      "${LocaleKeys.Included_in_type.tr()}:",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: HexColor("#F5F5F6")),
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      children: routeOptions.map((e) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                results["routeOption"][e]["name"],
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                ],
              ),
            ),
            if(results["status"] == "accepted" && results["paid"] == null) Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(text: "${LocaleKeys.select_payment_method.tr()}:", top: 0),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
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
                    Expanded(
                      child: RichText(
                        maxLines: 3,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 15
                            ),
                            children: [
                              TextSpan(
                                text: LocaleKeys.i_agree.tr(),
                                style: new TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: LocaleKeys.privacy.tr(),
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch("https://travelcars.uz/rules");
                                  },
                              ),
                              TextSpan(
                                text: LocaleKeys.and.tr(),
                                style: new TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: LocaleKeys.oferta.tr(),
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
                      Dialogs.OplataDialog(context);
                      return;
                    }
                    String type = "click";
                    payments.forEach((element) {
                      if(element["chosen"]) {
                        type = element["icon"];
                      }
                    });

                    int id = results["id"];
                    double amount = 0;
                    HomeScreen.kurs.forEach((element) {
                      if(element["code"] == "UZS") {
                        amount = double.parse(results["price"]) * element["rate"];
                      }
                    });
                    switch(type) {
                      case "click":
                        launch("https://my.click.uz/services/pay?service_id=13729&merchant_id=9367&amount=$amount&transaction_param=$id");
                        break;
                      case "payme":
                        String data = "m=5cd1820b1722d50474387f3a;ac.booking_id=$id;a=${amount * 100}";
                        var bytes = utf8.encode(data);
                        var base64 = base64Encode(bytes);
                        launch("https://checkout.paycom.uz/$base64");
                        break;
                      case "mastercard":
                        launch("https://travelcars.uz/octo/pay/$id/mCard");
                        break;
                      case "visa":
                        launch("https://travelcars.uz/octo/pay/$id/Visa");
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
                        LocaleKeys.Payment.tr(),
                        style: TextStyle(
                          fontSize: 20,
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
          ],
        ),
      ),
    );
  }

  Widget _text({text, double top = 20.0}) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 10, top: top),
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

}
