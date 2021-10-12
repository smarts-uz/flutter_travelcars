import 'package:flutter/material.dart';

class DropButtonMny extends StatefulWidget {
  const DropButtonMny({Key? key}) : super(key: key);

  @override
  _DropButtonMnyState createState() => _DropButtonMnyState();
}

class _DropButtonMnyState extends State<DropButtonMny> {
  String? dropvalue;

  List<String> Items = <String>["UZS", "USD", "RUB"];

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
            value: dropvalue,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                dropvalue = newValue!;
              });
            },
            items: Items.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                    ),
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
