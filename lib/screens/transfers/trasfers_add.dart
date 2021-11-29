import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/dummy_data/cities_list.dart';
import 'package:travelcars/screens/home/home_screen.dart';


class TransfersAdd extends StatefulWidget {
  const TransfersAdd({Key? key}) : super(key: key);

  @override
  _TransfersAddState createState() => _TransfersAddState();
}

class _TransfersAddState extends State<TransfersAdd> {
  List<String> directions = [
    'Meeting',
    'The wire'
  ];
  int i = 1;

  List<String> city = [];
  late final List<DropdownMenuItem<String>> cities;
  late List api_cities;
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
      "direction": 0,
      "city": city[0],
      "day": DateTime.now(),
      "time": TimeOfDay.now(),
      "controllers4": [
        for (int i = 0; i < 4; i++)
          TextEditingController()
      ],},
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add transfer',
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
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
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .75,
            child: ListView.builder(
                itemCount: i,
                itemBuilder: (context, index) {
                  Widget TFF(TextEditingController controller, String? hint, double height) {
                    return Container(
                      width: double.infinity,
                      height: height,
                      padding: EdgeInsets.only(left: 12),
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        decoration: InputDecoration(
                          hintText: hint,
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
                        keyboardType: hint == "Quantity of passengers" ? TextInputType.number : TextInputType.text,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 20
                        ),
                        expands: false,
                        maxLines: height == 165 ? 7 : 2,
                      ),
                    );
                  }
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(16, 24, 16, 24),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      margin:EdgeInsets.all(17),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              child: Text(
                                "${index + 1}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [0, 1].map((int indexr) => Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width*.4,
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Radio<int>(
                                        value: indexr,
                                        groupValue: data[index]["direction"],
                                        onChanged: (int? value) {
                                          if (value != null) {
                                            setState(() => data[index]["direction"] = value);
                                            print(value);
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        directions[indexr],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              ).toList(),
                            ),
                            Container(
                              width: double.infinity,
                              height: 55,
                              padding: EdgeInsets.only(left: 12, right: 6),
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  menuMaxHeight: MediaQuery.of(context).size.height * .5,
                                  hint: Text(
                                      "City",
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black
                                      )
                                  ),
                                  dropdownColor: Colors.grey[50],
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  value: data[index]["city"],
                                  isExpanded: true,
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black
                                  ),
                                  underline: SizedBox(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      data[index]["city"] = newValue!;
                                    });
                                  },
                                  items: cities,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 55,
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: ListTile(
                                title: Text(
                                  "${DateFormat('dd/MM/yyyy').format(data[index]["day"])}",
                                ),
                                trailing: IconButton(
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
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 55,
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: ListTile(
                                title: Text(
                                  "${data[index]["time"].format(context)}",
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.timer_rounded),
                                  onPressed: () {
                                    final DateTime now = DateTime.now();
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
                                    ).then((TimeOfDay? value) {
                                      if (value != null) {
                                        setState(() {
                                          data[index]["time"] = value;
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            TFF(data[index]["controllers4"][0], "Quantity of passengers", 55),
                            TFF(data[index]["controllers4"][1], "From", 55),
                            TFF(data[index]["controllers4"][2], "To", 55),
                            TFF(data[index]["controllers4"][3], "The address of the place to pick up from.", 165),
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
                      SizedBox(width: 10),
                      Text(
                        '---  Delete',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  onPressed: (){
                    setState(() {
                        if(i>1) {
                          data.removeAt(i-1);
                          i--;
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
                      SizedBox(width: 10),
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
                      if(i<5) i++;
                      data.add({
                        "direction": 0,
                        "city": city[0],
                        "day": DateTime.now(),
                        "time": TimeOfDay.now(),
                        "controllers4": [
                          for (int i = 0; i < 4; i++)
                            TextEditingController()
                        ],
                      },
                      );
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
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40)
            ),
            height: MediaQuery.of(context).size.height*.050,
            width: MediaQuery.of(context).size.width*.70,
            child:  RaisedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  bool isValid = true;
                  List<Map<String, dynamic>> info = [];
                  data.forEach((element) {
                    int cityID = 0;
                    api_cities.forEach((cityid) {
                      if(cityid["name"] == element["city"]) {
                        cityID = cityid["city_id"];
                      }
                    });
                    info.add({
                      "from": "${element["controllers4"][1].text}",
                      "to": "${element["controllers4"][2].text}",
                      "type": element["direction"] == 0 ? "meeting" : "cunduct",
                      "city_id": "$cityID",
                      "date": "${DateFormat('dd.MM.yyyy').format(element["day"])}",
                      "time": "${element["time"].format(context).substring(0, 5)}",
                      "quantity": "${element["controllers4"][0].text}",
                      "additional": "${element["controllers4"][3].text}",
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
                    try{
                      String url = "${AppConfig.BASE_URL}/postTransfers_";
                      final prefs = await SharedPreferences.getInstance();
                      String token = json.decode(prefs.getString('userData')!)["token"];
                      final result = await http.post(
                          Uri.parse(url),
                          headers: {
                            "Authorization": "Bearer $token",
                          },
                          body: {
                            "transfers" : "${json.encode(info)}"
                          }
                      );
                      print(json.decode(result.body)['message']);
                      Dialogs.ZayavkaDialog(context);
                    } catch (error) {
                      Dialogs.ErrorDialog(context);
                    }
                  }
                },
                child: Text('Submit your application'),
                color: Colors.blue,
              ),
            ),
          SizedBox(
            height: 30,
          )
        ],
      ),
      ),
    );
  }
}
