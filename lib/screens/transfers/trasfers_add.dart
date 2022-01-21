import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/translations/locale_keys.g.dart';


class TransfersAdd extends StatefulWidget {
  const TransfersAdd({Key? key}) : super(key: key);

  @override
  _TransfersAddState createState() => _TransfersAddState();
}

class _TransfersAddState extends State<TransfersAdd> {
  final ScrollController _controller = ScrollController();

  List<String> directions = [
    '${LocaleKeys.meeting.tr()}',
    '${LocaleKeys.Drop_of.tr()}'
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

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.add_transfer.tr(),
          style: TextStyle(
            fontSize: 21,
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
            size: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .73,
            child: ListView.builder(
              controller: _controller,
                itemCount: i,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      margin:EdgeInsets.all(12),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              maxRadius: 18,
                              child: Text(
                                "${index + 1}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [0, 1].map((int indexr) => Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width*.4,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 20,
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
                              height: 45,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  menuMaxHeight: MediaQuery.of(context).size.height * .5,
                                  hint: Text(
                                      LocaleKeys.city.tr(),
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
                            GestureDetector(
                              onTap: () {
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
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 12),
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
                                        fontSize: 18
                                      ),
                                    ),
                                    Icon(Icons.calendar_today),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
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
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${data[index]["time"].format(context)}",
                                      style: TextStyle(
                                        fontSize: 19
                                      ),
                                    ),
                                    Icon(Icons.timer_rounded),
                                  ],
                                ),
                              ),
                            ),
                            TFF(data[index]["controllers4"][0], "${LocaleKeys.Quantity_of_passengers.tr()}", 48, isNumber: true),
                            TFF(data[index]["controllers4"][1], "${LocaleKeys.From.tr()}", 48),
                            TFF(data[index]["controllers4"][2], "${LocaleKeys.To.tr()}", 48),
                            TFF(data[index]["controllers4"][3], "${LocaleKeys.The_address_of_the_place_to_pick_up_from.tr()}", 110),
                          ]
                      ),
                    ),
                  );
                },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if(i < 10) Container(
                height: 35,
                width: 140,
                child: RaisedButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 5),
                      Text(
                        LocaleKeys.add.tr(),
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if(i <= 10) i++;
                    data.add({
                      "direction": 0,
                      "city": city[0],
                      "day": DateTime.now(),
                      "time": TimeOfDay.now(),
                      "controllers4": [
                        for (int i = 0; i < 4; i++)
                          TextEditingController()
                      ],
                    });
                    setState(() {

                    });

                    Future.delayed(const Duration(milliseconds: 500), () async {
                      _scrollDown();
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
              if(i > 1) Container(
                height: 35,
                width: 140,
                child: RaisedButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5),
                      Text(
                        LocaleKeys.delete.tr(),
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  onPressed: (){
                    if(i > 1) {
                      data.removeAt(i-1);
                      i--;
                    }
                    setState(() {

                    }
                    );

                    Future.delayed(const Duration(milliseconds: 500), () async {
                      _scrollDown();
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.red
                      )
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40)
            ),
            height: MediaQuery.of(context).size.height* 0.05,
            width: MediaQuery.of(context).size.width*.70,
            child:  RaisedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final prefs = await SharedPreferences.getInstance();
                  if(prefs.containsKey("userData")) {
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
                    String empty_gap = " ";
                    info.forEach((element) {
                      element.forEach((key, value) {
                        if(value == "") {
                          empty_gap = key;
                          isValid = false;
                        }
                      });
                    });
                    if(isValid) {
                      try{
                        String url = "${AppConfig.BASE_URL}/postTransfers";
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
                    } else {
                      ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}: $empty_gap");
                    }
                  } else {
                    Dialogs.LoginDialog(context);
                  }
                },
                child: Text(
                  LocaleKeys.submit_your_application.tr(),
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                color: Colors.blue,
              ),
          ),
        ],
        ),
      ),
    );
  }
  Widget TFF(TextEditingController controller, String? hint, double height, {isNumber = false}) {
    return Container(
      width: double.infinity,
      height: height,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(left: 12),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 19
        ),
        expands: false,
        maxLines: height == 165 ? 7 : 2,
      ),
    );
  }
}
