import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/login/components/drop_button_mny.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
class DropButton extends StatefulWidget {
  const DropButton({Key? key}) : super(key: key);
  static String? dropdawnvalue;
  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {

  List<String> Items = <String>[
    "ENG",
    "RUS",
    "UZB",
  ];

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
        DropButton.dropdawnvalue = jsonDecode(prefs.getString("settings")!)["locale"];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, ),
      margin: EdgeInsets.all(16),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey),
          ),
      child: DropdownButtonHideUnderline(
        child: Container(
          child:DropdownButton<String>(
            hint: Text(LocaleKeys.choose_language.tr()),
            dropdownColor: Colors.grey[50],
            icon: Icon(Icons.keyboard_arrow_down),
            value: DropButton.dropdawnvalue,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (String? newValue)  {
              setState(() {
                DropButton.dropdawnvalue = newValue!;
              });
            },
            items:
            Items.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                        fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 19,
                      color: HexColor('#3C3C43'),),
                  ),);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
