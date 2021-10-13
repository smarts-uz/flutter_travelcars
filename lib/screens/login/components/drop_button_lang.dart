import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class DropButton extends StatefulWidget {
  const DropButton({Key? key}) : super(key: key);

  @override
  _DropButtonState createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String? dropdawnvalue ;
  List<String> Items = <String>[
    "UZB",
    "ENG",
    "RUS"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 18, right: 18, ),
      margin: EdgeInsets.all(16),
      height: 54,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey),
          ),
      child: DropdownButtonHideUnderline(
        child: Container(
          child:DropdownButton<String>(
            hint: Text("Выберите язык"),
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
                      fontSize: 15,
                      color: HexColor('#3C3C43'),),
                  ),);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
