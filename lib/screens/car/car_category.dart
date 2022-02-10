import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/search/search_result.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class CarCategory extends StatefulWidget {
  final String name;
  final String meta_url;

  CarCategory(this.name, this.meta_url);

  @override
  State<CarCategory> createState() => _CarCategoryState();
}

class _CarCategoryState extends State<CarCategory> {
  bool isLoading = true;
  List<int> indexes = [];
  List<Map<String, dynamic>> names = [
    {
      "name": LocaleKeys.class_atp.tr(),
      "icon": Icons.directions_car,
      "data": "class"
    },
    {
      "name": LocaleKeys.Quantity.tr(),
      "icon": Icons.people_outline,
      "data": "place"
    },
    {
      "name": LocaleKeys.Quantity_.tr(),
      "icon": Icons.home_repair_service_outlined,
      "data": "place_bag"
    },
    {
      "name": LocaleKeys.Air_conditioning.tr(),
      "icon": Icons.ac_unit_outlined,
      "data": "cooler"
    },
  ];

  List<dynamic> categories = [];
  
  @override
  void initState() {
    super.initState();
    getCategory();
  }
  
  void getCategory() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/carmodels/${widget.meta_url}/all?lang=${SplashScreen.til}");
    final response = await http.get(url);
    setState(() {
      categories = json.decode(response.body);
      isLoading = false;
    });
    for(int i = 0; i < categories.length; i++) {
      indexes.add(i);
    }
  }

  @override
  void dispose() {
    super.dispose();
    isLoading = false;
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
              size: 25
          ),
        ),
        title: Text(
          widget.name,
          maxLines: 2,
          style:TextStyle(
              fontSize: 21,
              color: Colors.white
          ),
        ),
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : categories.isEmpty ? Center (
        child: Text(
          LocaleKeys.No_car_categories_are_found.tr(),
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ) : SingleChildScrollView(
        child: Column(
          children: indexes.map((index) => GestureDetector(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResult(carCategory: categories[index]["id"])
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
                          categories[index]["name"] ?? " ",
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
                                "${categories[index]["quantity"] ?? "0"}",
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
                        margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0),
                        child: categories[index]["image"] == null ? Image.asset(
                          "assets/images/no_car.jpg",
                          fit: BoxFit.contain,
                        ) : Image.network(
                          "${AppConfig.image_url}/car-models/${categories[index]["image"]}",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            print(error);
                            return Image.asset(
                              "assets/images/no_car.jpg",
                              fit: BoxFit.contain,
                            );
                          },
                        )
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .5,
                        padding: EdgeInsets.only(right: 3.0),
                        child: Column(
                          children: [0, 1, 2, 3].map((index_in) => Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  names[index_in]["icon"],
                                  color: Colors.orange,
                                  size: 27.0,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    "${names[index_in]["name"]}: ${
                                        index_in == 3 ?
                                        categories[index][names[index_in]["data"]] == 1 ?
                                        "${LocaleKeys.yes.tr()}" : "${LocaleKeys.no.tr()}" :
                                        categories[index][names[index_in]["data"]] ?? "--"
                                    }",
                                    style: TextStyle(
                                        fontSize: 15.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          )).toList(),
        ),
      ),
    );
  }
}
