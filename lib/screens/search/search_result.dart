import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  List<Map<String, dynamic>> results = [
    {
      "name": "Mercedes Sprinter",
      "year": "2015",
      "id": "MS-701AFA",
      "views": "5324",
      "image": "assets/images/auto.jpg",
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
            icon: Icon(Icons.view_headline),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) => Card(

          )
      ),
    );
  }
}
