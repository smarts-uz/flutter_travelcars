import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/route/route_add.dart';
import 'package:travelcars/screens/search/details_screen.dart';
import 'package:travelcars/screens/search/search.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/transfers/trasfers_add.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:geocoding/geocoding.dart';

class SearchResult extends StatefulWidget {
  final Map<dynamic, dynamic> search_body;
  final int carCategory;
  final int cityTour;
  final String? CityStart;
  final String? CityEnd;

  SearchResult({
    this.search_body = const {},
    this.carCategory = -1,
    this.cityTour = 1,
    this.CityStart = "",
    this.CityEnd = "",
  });


  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  double min_price = 10;
  double max_price = 1000;
  bool isLoading = true;
  String refund = "";
  Map<String, Location> points = {};
  List<dynamic> routes = [];
  List<String> icons = [
    "assets/icons/places.jpg",
    "assets/icons/big_bag.jpg",
    "assets/icons/small_bag.jpg",
    "assets/icons/doors.jpg",
  ];

  @override
  void initState() {
    super.initState();
    if(widget.cityTour > -1) getCityTourPoints();
    if(widget.CityEnd!.isNotEmpty && widget.CityStart!.isNotEmpty)  getTwoCitiesPoints();
    getSearchResult();
  }

  void getSearchResult() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/sort");
    if(widget.carCategory > -1) {
      SearchScreen.radioVal1 = 0;
      for(var element in HomeScreen.city_list) {
        if(element["city_id"] == 1) {
          SearchScreen.SelectedVal1 = element["name"];
        }

        if(element["city_id"] == 24) {
          SearchScreen.SelectedVal2 = element["name"];
        }
      }

      final result_nonreverse = await http.post(
          url,
          body: {
            "reverse": "0",
            "city_start": "1",
            "cities[]": "24",
            "car_models[0]": "${widget.carCategory}",
            "lang": "${SplashScreen.til}",
          }
      );

      print("Non-reverse: ${jsonDecode(result_nonreverse.body)["routes"].toString()}");

      if(jsonDecode(result_nonreverse.body)["routes"].isNotEmpty) {
        routes.addAll(jsonDecode(result_nonreverse.body)["routes"]);
        refund = jsonDecode(result_nonreverse.body)["commission"] + " %";
        min_price = jsonDecode(result_nonreverse.body)["min_price"].toDouble();
        max_price = jsonDecode(result_nonreverse.body)["max_price"].toDouble();
      }

    } else {
      print(widget.search_body);
      final response = await http.post(
          url,
          body: widget.search_body
      );

      if(jsonDecode(response.body)["routes"].isNotEmpty) {
        routes = jsonDecode(response.body)["routes"];
        refund = jsonDecode(response.body)["commission"] + " %";
        min_price = jsonDecode(response.body)["min_price"].toDouble();
        max_price = jsonDecode(response.body)["max_price"].toDouble();
      }

    }
    print("All: ${routes.toString()}");
    setState(() {
      isLoading = false;
    });
  }

  void getCityTourPoints() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getWaypoints/${widget.cityTour}");
    final response  = await http.get(url);
    if(jsonDecode(response.body).isNotEmpty) {
      jsonDecode(response.body).forEach((element) async {
        await locationFromAddress(element["data"]).then((locations) {
          if (locations.isNotEmpty) {
            points.addAll({
              "${element["data"]}": locations[0]
            });
          }
        });
      });
    }
  }

  void getTwoCitiesPoints() async {
    await locationFromAddress(widget.CityStart!).then((locations) {
      if (locations.isNotEmpty) {
        points.addAll({
          "${widget.CityStart}": locations[0]
        });
      }
    });

    await locationFromAddress(widget.CityEnd!).then((locations) {
      if (locations.isNotEmpty) {
        points.addAll({
          "${widget.CityEnd}": locations[0]
        });
      }
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
          LocaleKeys.Results_of_searching.tr(),
          maxLines: 3,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21
          ),
        ),
        actions: [
         Builder(
            builder: (ctx) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(ctx).openEndDrawer();
                },
                icon: SvgPicture.asset("assets/icons/list.svg"),
              );
            }
          )
        ],
      ),
      endDrawer: Drawer(
        child: SearchScreen(isDrawer: true, max_val: max_price, min_val: min_price,),
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : routes.isEmpty ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black
                ),
                children: [
                  TextSpan(text: "${LocaleKeys.no_matching_1.tr()}\n\n", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                  TextSpan(text: LocaleKeys.No_matching_results_are_found.tr()),
                ]
            ),
          ),
          SizedBox(height: 25),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * .6,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TransfersAdd()
                      )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.airplanemode_active,
                      color: Colors.black,
                    ),
                    Text(
                      "  ${LocaleKeys.transfer.tr()}",
                      style: TextStyle(
                        fontSize: 17
                      ),
                    )
                  ],
                )
            ),
          ),
          SizedBox(height: 15),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * .6,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RouteAdd()
                      )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      color: Colors.black,
                    ),
                    Text(
                      "  ${LocaleKeys.route.tr()}",
                      style: TextStyle(
                          fontSize: 17
                      ),
                    )
                  ],
                )
            ),
          ),
        ],
      ) : ListView.builder(
          itemCount: routes.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> car = routes[index]["car"];
            List<dynamic> options = routes[index]["route_options"];
            List<int> icon_numbers = [];
            icon_numbers.add(car["places"]);
            icon_numbers.add(car["big_bags"]);
            icon_numbers.add(car["small_bags"]);
            icon_numbers.add(car["doors"]);
            List<int> indexes_options = [];
            for(int i = 0; i < options.length; i++) {
              indexes_options.add(i);
            }
            String route_name = routes[index]["city"]["name"] + " - ${routes[index]["cities"][0]["name"]}";
            if(routes[index]["reverse"] == 1) {
              route_name = route_name + " - ${routes[index]["city"]["name"]}";
            }
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, bottom: 8, top: 15),
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: routes[index]["status"] == 1 ? Colors.red : Colors.green,
                          size: 22,
                        ),
                        SizedBox(width: 13),
                        Text(
                          routes[index]["status"] == 1 ? "${LocaleKeys.confirmation_requires.tr()}" : "${LocaleKeys.Instant_confirmation.tr()}",
                          style: TextStyle(
                            fontSize: 17,
                            color: routes[index]["status"] == 1 ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, bottom: 3),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${car["title"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, bottom: 3),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${LocaleKeys.year_of_issue.tr()}: ${car["year"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 3, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${LocaleKeys.id_number.tr()}: ${car["uid"]}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    height: 190,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: car["images"] == null ?
                    Image.asset(
                      "assets/images/no_image.png",
                      fit: BoxFit.cover,)
                        : Image.network(
                        "${AppConfig.image_url}/cars/${car["images"][0]["original"]}",
                        fit: BoxFit.contain
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      alignment: Alignment.centerLeft,
                      height: 50,
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [0, 1, 2, 3].map((e) => Container(
                            height: 40,
                            width: 50,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(icons[e], fit: BoxFit.cover,),
                                  Text("${icon_numbers[e]}"),
                                ]
                            ),
                          )
                          ).toList()
                      )
                  ),
                  if(options.isNotEmpty) Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${LocaleKeys.Included_in_type.tr()}:",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  if(options.isNotEmpty) Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5, left: 15, right: 5),
                    child: Column(
                      children: indexes_options.map((i) => Row(
                        children: [
                          Icon(Icons.check, color: Colors.green, size: 20,),
                          Expanded(
                            child: Text(
                              options[i]["name"],
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 18,
                                  height: 1.6
                              ),
                            ),
                          )
                        ],
                      ),).toList(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 3),
                    child: ListTile(
                      title: Text(
                        route_name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.watch_later_outlined, color: Colors.orange,),
                            SizedBox(width: 8),
                            Text(
                              "${routes[index]["date"]}",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 18),
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: '${LocaleKeys.The_cost_of_the_trip.tr()} '),
                          TextSpan(text: '${LocaleKeys.for_one_day.tr()}', style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 18, bottom: 4.0),
                    alignment: Alignment.center,
                    child: Text(
                      "${(routes[index]["price"] * app_kurs).toStringAsFixed(2)} ${SplashScreen.kurs}",
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
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                routes[index],
                                points,
                                refund,
                              )
                          )
                      );
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(top: 5, bottom: 8),
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
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        )
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
