import 'package:flutter/material.dart';

class FourthScreen extends StatefulWidget {
  @override
  _FourthScreenState createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  String? dropdawnvalue;

  List<String> _money = <String>["UZS", "USD", "RUB"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text("Настройка языка и курса"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 17, top: 40),
          child: Container(
            padding: EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            margin: EdgeInsets.all(16),
            height: 54,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ]),
            child: DropdownButtonHideUnderline(
              child: Container(
                child: DropdownButton<String>(
                  hint: Text("UZS"),
                  dropdownColor: Colors.grey[50],
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: dropdawnvalue,
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdawnvalue = newValue!;
                    });
                  },
                  items: _money.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
