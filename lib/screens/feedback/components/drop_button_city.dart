import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class DropButtonCity extends StatefulWidget {
  const DropButtonCity({Key? key}) : super(key: key);

  @override
  _DropButtonCityState createState() => _DropButtonCityState();
}

class _DropButtonCityState extends State<DropButtonCity> {
  String? dropDawnValue ;
  List<String> _items = <String>[
    "Tashkent",
    "Samarkand",
    "Buxoro",
    "Xiva",
    "Andijon",
  ];
  final TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 6,right: 25 ),
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
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
          child:DropdownButton<String>(
            hint: Text("Страна"),
            dropdownColor: Colors.grey[50],
            icon: Icon(Icons.keyboard_arrow_down),
            value: dropDawnValue,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                dropDawnValue = newValue!;
              });
            },
            items:
            _items.map<DropdownMenuItem<String>>((value) {
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
