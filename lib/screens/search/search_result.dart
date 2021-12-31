import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/search/details_screen.dart';
import 'package:travelcars/screens/search/search.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';

class SearchResult extends StatefulWidget {
  final List<dynamic> routes;

  SearchResult(this.routes);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<String> icons = [
    "assets/icons/places.jpg",
    "assets/icons/big_bag.jpg",
    "assets/icons/small_bag.jpg",
    "assets/icons/doors.jpg",
  ];


  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
        title: Text(
          "Results of searching",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25
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
        child: SearchScreen(isDrawer: true,),
      ),
      body: widget.routes.isEmpty ? Center(
        child: Text(
          "No items found"
        ),
      ) : ListView.builder(
          itemCount: widget.routes.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> car = widget.routes[index]["car"];
            List<dynamic> options = widget.routes[index]["route_options"];
            List<int> icon_numbers = [];
            icon_numbers.add(car["places"]);
            icon_numbers.add(car["big_bags"]);
            icon_numbers.add(car["small_bags"]);
            icon_numbers.add(car["doors"]);
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
                        Icon(Icons.info_outline, color: Colors.red),
                        SizedBox(width: 13),
                        Text(
                          "Confirmation requires",
                          style: TextStyle(
                            fontSize: 20,
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
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, bottom: 3),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Made year: ${car["year"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 3, bottom: 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "ID number: ${car["uid"]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
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
                        fit: BoxFit.cover
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
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "The tariff includes:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    height: options.length * 35.0,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5, bottom: 8, left: 15),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: options.length,
                        itemBuilder: (context, i) => Container(
                          height: 30,
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              Text(
                                options[i]["name"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 17
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'The cost of the trip '),
                            TextSpan(text: 'for 1 day', style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                      )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "${(widget.routes[index]["price"] * app_kurs).toStringAsFixed(0)} ${SplashScreen.kurs}",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen(widget.routes[index]))
                      );
                    },
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
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
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
