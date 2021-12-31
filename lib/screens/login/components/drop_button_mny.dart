import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DropButtonMny extends StatefulWidget {
  const DropButtonMny({Key? key}) : super(key: key);
  static String? dropdawnvalue;
  @override
  _DropButtonMnyState createState() => _DropButtonMnyState();
}

class _DropButtonMnyState extends State<DropButtonMny> {

  List<String> Items = <String>["UZS", "USD", "RUB", "EUR"];

  @override
  void initState() {
    super.initState();
    current_locale();
  }

  Future<void> current_locale() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey("settings")) {
      return;
    } else {
      setState(() {
        DropButtonMny.dropdawnvalue = jsonDecode(prefs.getString("settings")!)["currency"];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      margin: EdgeInsets.all(16),
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: Container(
          child: DropdownButton<String>(
            hint: Text("Выберите валюту"),
            dropdownColor: Colors.grey[50],
            icon: Icon(Icons.keyboard_arrow_down),
            value: DropButtonMny.dropdawnvalue,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                DropButtonMny.dropdawnvalue = newValue!;
              });
            },
            items: Items.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      color: HexColor('#3C3C43'),
                    ),
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
