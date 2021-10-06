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

  List<String> sort = [
    "By price",
    "By capacity"
  ];
  int? _radioVal1;
  int? _radioVal2;
  RangeValues _currentRangeValues = RangeValues(10, 500);

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

  var number_controller = TextEditingController();

  List<Map<String, dynamic>> autoTypes = [
    {
      "text": "Cars",
      "check_box": false
    },
    {
      "text": "Microbus",
      "check_box": false
    },{
      "text": "Midibus",
      "check_box": false
    },{
      "text": "Bus",
      "check_box": false
    },
    {
      "text": "VIP - auto",
      "check_box": false
    },
  ];

  List<Map<String, dynamic>> autoOptions = [
    {
      "text": "Air conditioning",
      "check_box": false
    },
    {
      "text": "Mikrofon",
      "check_box": false
    },{
      "text": "Fridge",
      "check_box": false
    },{
      "text": "Tv",
      "check_box": false
    },
    {
      "text": "4WD",
      "check_box": false
    },
    {
      "text": "First aid kit",
      "check_box": false
    },
    {
      "text": "Airbags",
      "check_box": false
    },
    {
      "text": "Fire extinguisher",
      "check_box": false
    },
    {
      "text": "Plumbing cabin",
      "check_box": false
    },
  ];

  List<Map<String, dynamic>> tarif = [
    {
      "text": "Car delivery to a convenient place",
      "check_box": false
    },
    {
      "text": "Fuel cost",
      "check_box": false
    },{
      "text": "Driver nutrition",
      "check_box": false
    },{
      "text": "Parking payments",
      "check_box": false
    },
  ];

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
                        groupValue: this._radioVal1,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() => this._radioVal1 = value);
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
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  hintText: "Quantity of passengers",
                ),
                controller: number_controller,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                style: TextStyle(
                  fontSize: 20
                ),
                expands: false,
                maxLines: 1,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Text(
                'Sort by result',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [0, 1].map((int index) => Container(
                alignment: Alignment.centerLeft,
                height: 40,
                width: double.infinity,
                //padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Radio<int>(
                      value: index,
                      groupValue: this._radioVal2,
                      onChanged: (int? value) {
                        if (value != null) {
                          setState(() => this._radioVal2 = value);
                          print(value);
                        }},
                    ),
                    Text(
                      sort[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
              child: Text(
                'Price',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "10",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: RangeSlider(
                      values: _currentRangeValues,
                      min: 10,
                      max: 500,
                      divisions: 10,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                        },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "500",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
              child: Text(
                'Auto types',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              height: autoTypes.length * 48,
              width: double.infinity,
              child: ListBox(autoTypes)
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
              child: Text(
                'Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 5, bottom: 5),
                height: autoOptions.length * 48,
                width: double.infinity,
                child: ListBox(autoOptions)
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
              child: Text(
                'Included in type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 5, bottom: 3),
                height: tarif.length * 48,
                width: double.infinity,
                child: ListBox(tarif)
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 12),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    number_controller = TextEditingController();
                    _selectedDate1 = DateTime.now();
                    _selectedDate2 = DateTime.now();
                    SelectedVal1 = "City";
                    SelectedVal2 = "City";
                    _currentRangeValues = RangeValues(10, 500);
                    _radioVal1 = null;
                    _radioVal2 = null;
                    for(int i = 0; i < autoTypes.length; i++) {
                      autoTypes[i]["check_box"] = false;
                    }
                    for(int i = 0; i < autoOptions.length; i++) {
                      autoOptions[i]["check_box"] = false;
                    }
                    for(int i = 0; i < tarif.length; i++) {
                      tarif[i]["check_box"] = false;
                    }
                  });
                },
                child: Text(
                  "Clear data",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),
                ),
              ),
            ),
            Container(
              height: 65,
              width: double.infinity,
              padding: EdgeInsets.only(top: 5, bottom: 15, left: 15, right: 15),
              child: RaisedButton(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Color.fromRGBO(0, 116, 201, 1),
                  padding: EdgeInsets.all(8),
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 27,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {

                  }
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class ListBox extends StatefulWidget {

  final List<Map<String, dynamic>> boxes;

  ListBox(@required this.boxes);
  @override
  _ListBoxState createState() => _ListBoxState();
}

class _ListBoxState extends State<ListBox> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        //padding: EdgeInsets.symmetric(vertical: 0),
        itemCount: widget.boxes.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() => widget.boxes[index]["check_box"] = value);
                  }
                },
                value: widget.boxes[index]["check_box"],
              ),
              Text(
                "${widget.boxes[index]["text"]}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          );
        }
        );
  }
}