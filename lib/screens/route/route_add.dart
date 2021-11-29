import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;

import '../../app_config.dart';

class RouteAdd extends StatefulWidget {
  const RouteAdd({Key? key}) : super(key: key);

  @override
  _RouteAddState createState() => _RouteAddState();
}

class _RouteAddState extends State<RouteAdd> {
  List<String> city = [];
  late final List<DropdownMenuItem<String>> cities;
  late List api_cities;
  int count = 1;
  DateTime? _selectedDate = DateTime.now();
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getcities();
  }

  void getcities() {
    api_cities = HomeScreen.city_list;
    api_cities.forEach((element) {
      city.add(element["name"]);
    });
    cities = city.map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
    ).toList();
    data.add({
      "city1": city[0],
      "city2": city[0],
      "day": DateTime.now(),
      "controllers2": [
        for (int i = 0; i < 2; i++)
          TextEditingController()
      ],
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add route',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .75,
              child: ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  Widget DDM (bool isCity1, String? hint) {
                    return Container(
                      width: double.infinity,
                      height: 55,
                      padding: EdgeInsets.only(left: 6, right: 6),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child:DropdownButtonHideUnderline(
                        child: Container(
                          child: DropdownButton<String>(
                            menuMaxHeight: MediaQuery.of(context).size.height * .5,
                            hint: Text(
                                hint!,
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black
                                )
                            ),
                            dropdownColor: Colors.grey[50],
                            icon: Icon(Icons.keyboard_arrow_down),
                            value: isCity1 ? data[index]["city1"] : data[index]["city2"],
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.black
                            ),
                            underline: SizedBox(),
                            onChanged: (String? newValue) {
                              setState(() {
                                isCity1 ? data[index]["city1"] = newValue! : data[index]["city2"] = newValue!;
                              });
                            },
                            items: cities,
                          ),
                        ),
                      ),
                    );
                  }
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child:Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      margin:EdgeInsets.all(17),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text('Trip ${index + 1}',
                                style: TextStyle(
                                    fontSize: 25  ,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            DDM(true, "From"),
                            DDM(false, "To"),
                            Container(
                              width: double.infinity,
                              height: 55,
                              padding: EdgeInsets.only(left: 8),
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${DateFormat('dd/MM/yyyy').format(data[index]["day"])}",
                                    style: TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2030),
                                      ).then((pickedDate) {
                                        if(pickedDate==null)
                                        {
                                          return;
                                        }
                                        setState(() {
                                          data[index]["day"] = pickedDate;
                                        });
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            TFF("Quantity of passengers", data[index]["controllers2"][0], 55),
                            TFF("The address of the place to pick up from.", data[index]["controllers2"][1], 165),
                          ]
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*.045,
                  width: MediaQuery.of(context).size.width*.40,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 10),
                        Text(
                          '--Delete',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      setState(() {
                        if(count>1) {
                          data.removeAt(count-1);
                          count--;
                        }
                      }
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: Colors.red
                        )
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*.045,
                  width: MediaQuery.of(context).size.width*.40,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.orange,
                        ),
                        SizedBox(
                            width: 10),
                        Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.orange,
                            fontSize: 18
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      setState(() {
                        if(count<5) count++;
                        data.add({
                          "city1": city[0],
                          "city2": city[0],
                          "day": DateTime.now(),
                          "controllers2": [
                            for (int i = 0; i < 2; i++)
                              TextEditingController()
                          ],
                        },);
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: Colors.orange
                        )
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4)
              ),
              height: MediaQuery.of(context).size.height*.050,
              width: MediaQuery.of(context).size.width*.70,
              child: RaisedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  bool isValid = true;
                  List<Map<String, dynamic>> info = [];
                  data.forEach((element) {
                    api_cities.forEach((cityid) {
                      if(cityid["name"] == element["city1"]) {
                        element["city1"] = cityid["city_id"];
                      }
                      if(cityid["name"] == element["city2"]) {
                        element["city2"] = cityid["city_id"];
                      }
                    });
                    info.add({
                      "from": "${element["city1"]}",
                      "to": "${element["city2"]}",
                      "date": "${DateFormat('dd-MM-yyyy').format(element["day"])}",
                      "passengers": "${element["controllers2"][0].text}",
                      "address": "${element["controllers2"][1].text}",
                    });
                  });
                  info.forEach((element) {
                    element.forEach((key, value) {
                      if(value == "") {
                        print(key);
                        isValid = false;
                      }
                    });
                  });
                  if(isValid) {
                    int ind = 0;
                    data.forEach((element_info) {
                      api_cities.forEach((element_city) {
                        setState(() {
                          if(element_info["city1"] == element_city["city_id"]) {
                            data[ind]["city1"] = element_city["name"];
                          }
                          if(element_info["city2"] == element_city["city_id"]) {
                            data[ind]["city2"] = element_city["name"];
                          }
                        });
                      });
                      ind++;
                    });
                    try {
                      String url = "${AppConfig.BASE_URL}/custom/booking/create";
                      final prefs = await SharedPreferences.getInstance();
                      String token = json.decode(prefs.getString('userData')!)["token"];
                      final result = await http.post(
                          Uri.parse(url),
                          headers: {
                            "Authorization": "Bearer $token",
                          },
                          body: {
                            "data" : "${json.encode(info)}"
                          }
                      );
                      print(json.decode(result.body)['message']);
                      List<Map<String, String>> routes = [];
                      data.forEach((element) {
                        routes.add({
                          "from": element["city1"],
                          "to": element["city2"],
                          "date": "${DateFormat('dd-MM-yyyy').format(element["day"])}",
                        });
                      });
                      Dialogs.TripDialog(context, routes);
                    } catch (error) {
                      Dialogs.ErrorDialog(context);
                    }
                  } else {
                    int ind = 0;
                    data.forEach((element_info) {
                      api_cities.forEach((element_city) {
                        setState(() {
                          if(element_info["city1"] == element_city["city_id"]) {
                            data[ind]["city1"] = element_city["name"];
                          }
                          if(element_info["city2"] == element_city["city_id"]) {
                            data[ind]["city2"] = element_city["name"];
                          }
                        });
                      });
                      ind++;
                    });
                  }
                },
                child: Text('Submit your application'),
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget TFF (String? hint_text, TextEditingController controller, double height) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.only(left: 6),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: hint_text,
          hintMaxLines: 3,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
        ),
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 20
        ),
        expands: false,
        maxLines: 7,
      ),
    );
  }
}



