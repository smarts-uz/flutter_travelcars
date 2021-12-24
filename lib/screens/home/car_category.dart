import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelcars/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/home/cars_list.dart';

class CarCategory extends StatefulWidget {
  final String name;
  final String meta_url;

  CarCategory(this.name, this.meta_url);

  @override
  State<CarCategory> createState() => _CarCategoryState();
}

class _CarCategoryState extends State<CarCategory> {
  List<Map<String, dynamic>> names = [
    {
      "name": "Class",
      "icon": Icons.directions_car
    },
    {
      "name": "Places with luggage",
      "icon": Icons.people_outline
    },
    {
      "name": "Places without luggage",
      "icon": Icons.home_repair_service_outlined
    },
    {
      "name": "Air conditioning",
      "icon": Icons.ac_unit_outlined
    },
  ];

  List<dynamic> categories = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }
  
  void getCategory() async {
    print(widget.meta_url);
    Uri url = Uri.parse("${AppConfig.BASE_URL}/carmodels/${widget.meta_url}/all?lang=uz");
    final response = await http.get(url);
    print(response.body);
    setState(() {
      categories = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28
          ),
        ),
        title: Text(
          widget.name,
          style:TextStyle(
              fontSize: 25,
              color: Colors.white
          ),
        ),
      ),
      body: categories.isEmpty ? Center(
        child: CircularProgressIndicator(),
      ) :
      SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0),
            physics: BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CarsList(categories[index]["name"], categories[index]["meta_url"])
                    )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5
                  )
                ),
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 18.0, top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categories[index]["name"],
                            style: TextStyle(
                              fontSize: 20.0
                            ),
                          ),
                          Container(
                              height: 27,
                              width: 27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Color.fromRGBO(239, 127, 26, 1),
                              ),
                              child: Center(
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .17,
                          width: MediaQuery.of(context).size.width * .32,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            "assets/images/malibu.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .16,
                          width: MediaQuery.of(context).size.width * .5,
                          padding: EdgeInsets.only(right: 3.0),
                          child: ListView.builder(
                              itemCount: 4,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      names[index]["icon"],
                                      color: Colors.orange,
                                      size: 27.0,
                                    ),
                                    Text(
                                      names[index]["name"],
                                      style: TextStyle(
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
