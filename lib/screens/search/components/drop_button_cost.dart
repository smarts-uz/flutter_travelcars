import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

List<Map<String, dynamic>> cost = [
  {
    'kun': '1 день',
    'narx': '1 284 000 UZS',
  },
  {
    'kun': '2 день',
    'narx': '2 568 000 UZS',
  },
  {
    'kun': '3 день',
    'narx': '3 852 000 UZS',
  },
  {
    'kun': '4 день',
    'narx': '5 136 000 UZS',
  },
  {
    'kun': '5 день',
    'narx': '6 420 000 UZS',
  },
  {
    'kun': '6 день',
    'narx': '7 704 000 UZS',
  },
  {
    'kun': '7 день',
    'narx': '8 988 000 UZS',
  },
];

class DrpBtnCost extends StatefulWidget {
  const DrpBtnCost({Key? key}) : super(key: key);

  @override
  _DrpBtnCostState createState() => _DrpBtnCostState();
}

class _DrpBtnCostState extends State<DrpBtnCost> {
  var drpdawnvalue = cost[0]['narx'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.only(left: 16,right: 16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
                border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ]),
            child: DropdownButtonHideUnderline(
              child: Container(
                child: DropdownButton<String>(
                  hint: Text("Страна"),
                  dropdownColor: Colors.grey[50],
                  icon: Icon(Icons.keyboard_arrow_down),
                  isExpanded: true,
                  underline: SizedBox(),
                  value: drpdawnvalue,
                  onChanged: (newValue) {
                    setState(() {
                      drpdawnvalue = newValue;
                    });
                  },
                  items: cost.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value['narx'],
                      child: Text(
                        value['kun'],
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          color: HexColor('#3C3C43'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: Container(
              padding: EdgeInsets.only(left: 16,right: 16 ),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[50],
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                    ),
                  ]),
              child: Center(
                child: Text(drpdawnvalue,
                  style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 15,
                  color: HexColor('#3C3C43'),
                ),),
              )),
        )
      ],
    );
  }
}
