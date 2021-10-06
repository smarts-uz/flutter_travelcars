import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<String> directions = [
    "One way",
    "Round trip",
  ];
  int _radioVal = 0;

  String? SelectedVal1;
  String? SelectedVal2;
  static const city = <String>[
    "Tashkent",
    "Buxoro",
    "Xiva",
    "Samarkand"
  ];
  final List<DropdownMenuItem<String>> cities = city.map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
  ).toList();

  DateTime? _selectedDate1 = DateTime.now();
  DateTime? _selectedDate2 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TravelCars'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/globus.svg',
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [0, 1].map((int index) => Container(
                height: 50,
                width: 180,
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Radio<int>(
                        value: index,
                        groupValue: this._radioVal,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() => this._radioVal = value);
                            print(value);
                          }},
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        directions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 6, right: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: ListTile(
                title: Text(
                  SelectedVal1 != null ? SelectedVal1! : "City",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: DropdownButton(
                  value: SelectedVal1,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => SelectedVal1 = newValue);
                    }
                    },
                  items: cities,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 6, right: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: ListTile(
                title: Text(
                  SelectedVal2 != null ? SelectedVal2! : "City",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: DropdownButton(
                  value: SelectedVal2,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => SelectedVal2 = newValue);
                    }
                  },
                  items: cities,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: ListTile(
                title: Text(
                    "${DateFormat('dd/MM/yyyy').format(_selectedDate2!)}",
                ),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2030),
                    ).then((pickedDate) {
                      if(pickedDate==null)
                      {
                        return;
                      }
                      setState(() {
                        _selectedDate2 = pickedDate;
                      });
                    });
                  },
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: ListTile(
                title: Text(
                  "${DateFormat('dd/MM/yyyy').format(_selectedDate1!)}",
                ),
                trailing: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2030),
                    ).then((pickedDate) {
                      if(pickedDate==null)
                      {
                        return;
                      }
                      setState(() {
                        _selectedDate1 = pickedDate;
                      });
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
