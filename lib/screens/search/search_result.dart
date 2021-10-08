import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  List<String> icons = [
    "assets/icons/places.svg",
   "assets/icons/big_bag.svg",
    "assets/icons/small_bag.svg",
    "assets/icons/doors.svg",
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
      "day": 1,
      "total": 3210000,
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
        "Fuel cost",
        "Parking payments",
      ],
      "day": 2,
      "total": 5410000,
    }
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Results of searching",
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
                ListTile(
                  leading: Icon(Icons.info_outline, color: Colors.red),
                  title: Text(
                      "Confirmation requires",
                    style: TextStyle(
                      fontSize: 20,
                    ),
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
                  child: Image.asset(results[index]["image"], fit: BoxFit.cover,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30,
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [0, 1, 2, 3].map(
                            (e) => Container(
                              width: 30,
                              child: ListTile(
                                leading: SvgPicture.asset(icons[e]),
                                title: Text("${results[index]["icon_numbers"][e]}"),
                              ),
                            )
                    ).toList(),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
