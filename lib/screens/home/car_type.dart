import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/search/details_screen.dart';
import 'package:http/http.dart' as http;

class CarType extends StatefulWidget {
 final String name;
 final int id;
 CarType(this.name, this.id);

  @override
  _CarTypeState createState() => _CarTypeState();
}

class _CarTypeState extends State<CarType> {

  List<String> icons = [
    "assets/icons/places.jpg",
    "assets/icons/big_bag.jpg",
    "assets/icons/small_bag.jpg",
    "assets/icons/doors.jpg",
  ];

  List< dynamic> results = [
    /*
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
    },*/
  ];

 @override
  void initState() {
    super.initState();
    getcars();
  }

  void getcars() async{
   String url = "${AppConfig.BASE_URL}/getCarTypeById/${widget.id}?lang=ru";
   final response = await http.get(Uri.parse(url));
   print(json.decode(response.body)["data"]);
   setState(() {
     results = json.decode(response.body)["data"];
     results.forEach((element) {
       List<int> icon_numbers = [];
       icon_numbers.add(element["places"]);
       icon_numbers.add(element["doors"]);
       icon_numbers.add(element["big_bags"]);
       icon_numbers.add(element["small_bags"]);
       element.addAll({
         "icon_numbers": icon_numbers,
       });
       List<String> images = [];
       element["images"].forEach((element) {
         images.add(element["original"]);
       });
       element.addAll({
         "images": images,
       });
     });
   });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         widget.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: SvgPicture.asset("assets/icons/list.svg"),
          )
        ],
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
                    "${results[index]["title"]}",
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
                    "ID number: ${results[index]["number"]}",
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
                  child: Image.network("https://travelcars.uz/uploads/cars/${results[index]["images"][0]}",
                  fit: BoxFit.cover,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  alignment: Alignment.centerLeft,
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [0, 1, 2, 3].map((e) => Container(
                      height: 50,
                      width: 60,
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