import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/bookings/booking_item_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  bool isLoading = true;

  List<String> icons = [
    "assets/icons/places.jpg",
    "assets/icons/big_bag.jpg",
    "assets/icons/small_bag.jpg",
    "assets/icons/doors.jpg",
  ];

  List<dynamic> results = [];

  @override
  void initState() {
    super.initState();
    getAllBookings();
  }

  void getAllBookings() async {
    final prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString('userData')!)["token"];
    Uri url = Uri.parse("${AppConfig.BASE_URL}/booking?lang=${SplashScreen.til}");
    final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        }
    );
    results = json.decode(response.body)["data"];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double app_kurs = 1;
    HomeScreen.kurs.forEach((element) {
      if(SplashScreen.kurs == element["code"]) {
        app_kurs = element["rate"].toDouble();
      }
    });
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
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
         LocaleKeys.bookings.tr(),
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 23
          ),
        ),
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : results.isEmpty ? Center(
        child: Text(
          LocaleKeys.no_booking_found.tr(),
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ) : ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            List<int> iconNumbers = [];
            iconNumbers.add(results[index]["car"]["places"]);
            iconNumbers.add(results[index]["car"]["big_bags"]);
            iconNumbers.add(results[index]["car"]["small_bags"]);
            iconNumbers.add(results[index]["car"]["doors"]);
            double day = 1.0;
            if(results[index]["price_data"] != null) {
              results[index]["price_data"].forEach((key, value) {
                if(value == results[index]["price"]) {
                  switch(key) {
                    case "one":
                      day = 1;
                      break;
                    case "two":
                      day = 2;
                      break;
                    case "three":
                      day = 3;
                      break;
                    case "half":
                      day = 0.5;
                  }
                }
              });
            }
            String? status = "Unknown";
            Color? color = Colors.grey;
            switch(results[index]['status']) {
              case "moderating":
                status = LocaleKeys.route_one_on_consideration.tr();
                color = Colors.amber;
                break;
              case "proceed":
                status = LocaleKeys.pending.tr();
                color =Colors.blue;
                break;
              case "rejected":
                color = Colors.red;
                status = LocaleKeys.rejected.tr();
                break;
              case "accepted":
                status = LocaleKeys.approved.tr();
                color = Colors.green;
                break;
            }

            String payment_status = LocaleKeys.naqd_pul.tr();
            switch(results[index]['paid']) {
              case "uzcard":
                payment_status = LocaleKeys.uzcard.tr();
                break;
              case "cash":
                payment_status = LocaleKeys.naqd_pul.tr();
                break;
              case "visa":
                payment_status = LocaleKeys.visa.tr();
                break;
              case "Visa":
                payment_status = LocaleKeys.visa.tr();
                break;
              case "mcard":
                payment_status = LocaleKeys.mcard.tr();
                break;
              case "transfer":
                payment_status = LocaleKeys.no_cash.tr();
                break;
            }

            List<int> indexes_options = [];
            for(int i = 0; i < results[index]["routeOption"].length; i++) {
              indexes_options.add(i);
            }

            String route_name = "";
            route_name = results[index]["cityStart"] + " - ${results[index]["cities"][0]}";
            if(results[index]["reverse"] == 1) {
              route_name = route_name + " - ${results[index]["cityStart"]}";
            }

            return Card(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${results[index]["car"]["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, bottom: 8, top: 4),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.status.tr()}:  ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              height: 25,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                "$status",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${LocaleKeys.price_condition.tr()}:  ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              height: 25,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: results[index]["paid"] != null ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                results[index]["paid"] != null ? "$payment_status" : "${LocaleKeys.unpaid.tr()}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: results[index]["images"] == null ||  results[index]["images"].isEmpty ? Image.asset(
                      "assets/images/no_car.jpg",
                      fit: BoxFit.contain,
                    ) : Image.network(
                      "${AppConfig.image_url}/cars/${results[index]["images"][0]["original"]}",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        print(error);
                        return Image.asset(
                          "assets/images/no_car.jpg",
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      alignment: Alignment.centerLeft,
                      height: 35,
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [0, 1, 2, 3].map((e) => Container(
                            height: 25,
                            width: 50,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(icons[e], fit: BoxFit.cover,),
                                  Text("${iconNumbers[e]}"),
                                ]
                            ),
                          )
                          ).toList()
                      )
                  ),
                  if(results[index]["routeOption"].isNotEmpty) Container(
                    padding: EdgeInsets.only(left: 15, top: 6, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${LocaleKeys.Included_in_type.tr()}:",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  if(results[index]["routeOption"].isNotEmpty) Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: indexes_options.map((i) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            Expanded(
                              child: Text(
                                results[index]["routeOption"][i]["name"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17
                                ),
                              ),
                            )
                          ],
                        ),
                      ),).toList(),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      route_name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.watch_later_outlined, color: Colors.orange,),
                        SizedBox(width: 8),
                        Text(
                          "${results[index]["date"].substring(0, 10)}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 4),
                      alignment: Alignment.center,
                      child:  RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 19.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: '${LocaleKeys.The_cost_of_the_trip.tr()} '),
                            if(SplashScreen.til == "uz") TextSpan(text: '${day == 0.5 ? day : day.toInt()} ${LocaleKeys.day.tr()} ${LocaleKeys.for_atp.tr()}', style: TextStyle(color: Colors.orange)),
                            if(SplashScreen.til != "uz") TextSpan(text: '${LocaleKeys.for_atp.tr()} ${day == 0.5 ? day : day.toInt()} ${(SplashScreen.til == "ru" && day == 1.0) ? "день" : LocaleKeys.day.tr()}', style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                      )
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${(double.parse(results[index]["price"]) * app_kurs).toStringAsFixed(2)} ${SplashScreen.kurs}",
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookingScreen(results[index], route_name)
                          )
                      );
                    },
                    child: Center(
                      child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Text(
                           LocaleKeys.details.tr(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
