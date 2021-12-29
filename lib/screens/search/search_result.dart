import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/screens/search/details_screen.dart';
import 'package:travelcars/screens/search/search.dart';

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

  List<Map<String, dynamic>> results = [
    {
      "name": "Mercedes Sprinter",
      "year": "2015",
      "id": "MS-701AFA",
      "views": "5324",
      "image": "assets/images/auto.jpg",
      "icon_numbers": [
        3, 2, 3, 4
      ],
      "places": 3,
      "big_bag": 2,
      "small_bag": 3,
      "doors": 4,
      "tarif": [
       "Car delivery to a convenient place",
       "Fuel cost",
       "Driver nutrition",
       "Parking payments",
      ],
      "total": "3 210 000",
    },
    {
      "name": "Mercedes Bus",
      "year": "2015",
      "id": "MS-7085FB",
      "views": "6597",
      "image": "assets/images/auto2.jpg",
      "icon_numbers": [
        7, 4, 6, 6
      ],
      "places": 7,
      "big_bag": 4,
      "small_bag": 6,
      "doors": 6,
      "tarif": [
        "Car delivery to a convenient place",
        "Parking payments",
      ],
      "total": "5 410 000",
    },
    {
      "name": "Mercedes Lux",
      "year": "2021",
      "id": "MS-702UFA",
      "views": "3256",
      "image": "assets/images/auto.jpg",
      "icon_numbers": [
        4, 2, 4, 2
      ],
      "places": 3,
      "big_bag": 2,
      "small_bag": 3,
      "doors": 4,
      "tarif": [
        "Car delivery to a convenient place",
        "Fuel cost",
        "Driver nutrition",
        "Parking payments",
        "Parking payments",
        "Parking payments",
      ],
      "total": "7 410 000",
    },
  ];



  @override
  Widget build(BuildContext context) {
    print(widget.routes);
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
      body: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) => Card(
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
                    "${results[index]["name"]}",
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
                    "Made year: ${results[index]["year"]}",
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
                    "ID number: ${results[index]["id"]}",
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
                  child: Image.asset(results[index]["image"], fit: BoxFit.cover),
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
                            Text("${results[index]["icon_numbers"][e]}"),
                          ]
                      ),
                    )
                    ).toList()
                  )
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 6, bottom: 5),
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
                  height: results[index]["tarif"].length * 35.0,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 5, bottom: 8, left: 15),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      itemCount: results[index]["tarif"].length,
                      itemBuilder: (context, i) => Container(
                        height: 30,
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            Text(
                              results[index]["tarif"][i],
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child:  RichText(
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
                    "${results[index]["total"]} UZS",
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
                      MaterialPageRoute(builder: (context) => DetailScreen())
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
          )
      ),
    );
  }
}
