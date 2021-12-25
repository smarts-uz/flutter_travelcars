import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:travelcars/dummy_data/cars.dart';
import 'package:travelcars/dummy_data/cities_list.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/search/search_result.dart';
import 'package:travelcars/screens/trip/trips.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class SearchScreen extends StatefulWidget {
  final bool isDrawer;
  SearchScreen({this.isDrawer=false});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = true;

  List<String> directions = [
    LocaleKeys.One_way.tr(),
    LocaleKeys.Round_trip.tr(),
  ];

  List<String> sort = [
    LocaleKeys.By_price.tr(),
    LocaleKeys.By_capacity.tr()
  ];
  static int? _radioVal1;
  static int? _radioVal2;
  static RangeValues _currentRangeValues = RangeValues(50, 250);

  static String? SelectedVal1;
  static String? SelectedVal2;

  static DateTime? _selectedDate1 = DateTime.now();
  static DateTime? _selectedDate2 = DateTime.now();

  static var number_controller = TextEditingController();

  static List<dynamic> autoTypes = [];
  Map<String, dynamic> categories = {};
  /*{
      "text": LocaleKeys.Cars.tr(),
      "check_box": false
    },
    {
      "text": LocaleKeys.Microbus.tr(),
      "check_box": false
    },
    {
      "text": LocaleKeys.Minibus.tr(),
      "check_box": false
    },{
      "text": LocaleKeys.Bus.tr(),
      "check_box": false
    },
    {
      "text": LocaleKeys.VIP_auto.tr(),
      "check_box": false
    },*/

  static List<Map<String, dynamic>> autoOptions = [
    {
      "name": LocaleKeys.Air_Conditional.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Mikrofon.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Fridge.tr(),
      "chosen": false
    },
    {
      "name": "Tv",
      "chosen": false
    },
    {
      "name": "4WD",
      "chosen": false
    },
    {
      "name": LocaleKeys.First_aid_kit.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Airbags.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Fire_extinguisher.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Plumbing_cabin.tr(),
      "chosen": false
    },
  ];

  static List<Map<String, dynamic>> tarif = [
    {
      "name": LocaleKeys.Car_delivery_to_a_convenient_place.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Fuel_cost.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Driver_nutrition.tr(),
      "chosen": false
    },
    {
      "name": LocaleKeys.Parking_payments.tr(),
      "chosen": false
    },
  ];

  List<String> city = [];
  late final List<DropdownMenuItem<String>> cities;
  late List api_cities;

  @override
  void initState() {
    super.initState();
    getcities();
    autoTypes = HomeScreen.cars_list;
    categories = HomeScreen.category_list;
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
  }


  @override
  Widget build(BuildContext context) {
    double catHeight = 0;
    List<dynamic> chosen_types = [];
    autoTypes.forEach((element) {
      if(element["chosen"]) {
        chosen_types.add(element);
        catHeight += categories["${element["name"]}"].length * 33.0 + 30.0;
      }
    });
    print("Chosens: $chosen_types");
    return Scaffold(
      appBar: AppBar(
        leading: widget.isDrawer ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 30,
              color: Colors.white,
            )
        ) : null,
        title: Text(
          LocaleKeys.Search_and_sort.tr(),
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          if(!widget.isDrawer) IconButton(
            icon: SvgPicture.asset(
              'assets/icons/globus.svg',
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => TripsScreen()
                  )
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, top: 15),
              child: Text(
                LocaleKeys.Search.tr(),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            widget.isDrawer ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [0, 1].map((int index) => Container(
                height: 50,
                width: 140,
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Radio<int>(
                        value: index,
                        groupValue: _radioVal1,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() => _radioVal1 = value);
                            print(value);
                          }},
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        directions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ) : Row(
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
                        groupValue: _radioVal1,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() => _radioVal1 = value);
                            print(value);
                          }},
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        directions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  value: SelectedVal1,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black
                  ),
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      SelectedVal1 = newValue!;
                    });
                  },
                  items: cities,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 18),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  value: SelectedVal2,
                  isExpanded: true,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black
                  ),
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      SelectedVal2 = newValue!;
                    });
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  hintText: "Quantity of passengers",
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
                controller: number_controller,
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
                LocaleKeys.Sort_by_result.tr(),
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
                      groupValue: _radioVal2,
                      onChanged: (int? value) {
                        if (value != null) {
                          setState(() => _radioVal2 = value);
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
                LocaleKeys.Price.tr(),
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
                    child: FittedBox(
                      child: Text(
                        "50",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: RangeSlider(
                      values: _currentRangeValues,
                      min: 50,
                      max: 250,
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
                    flex: 2,
                    child: Text(
                      "250",
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
              padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
              child: Text(
                LocaleKeys.Auto_types.tr(),
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, bottom: 5),
              height: autoTypes.length * 33,
              width: double.infinity,
              child: ListBox(autoTypes)
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                height: catHeight,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: chosen_types.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 7.0, bottom: 3.5),
                        child: Text(
                          chosen_types[index]["name"],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                      ),
                      SizedBox(
                          height: categories["${chosen_types[index]["name"]}"].length * 33.0,
                          child: ListBox(categories["${chosen_types[index]["name"]}"])
                      ),
                    ],
                  ),
                )
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, bottom: 5, top: 15.0),
              child: Text(
                LocaleKeys.Options.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                height: autoOptions.length * 33,
                width: double.infinity,
                child: ListBox(autoOptions)
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
              child: Text(
                LocaleKeys.Included_in_type.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                height: tarif.length * 33,
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
                    SelectedVal1 = null;
                    SelectedVal2 = null;
                    _currentRangeValues = RangeValues(50, 250);
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
                  LocaleKeys.Clear_data.tr(),
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
                        LocaleKeys.Search.tr(),
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    if(widget.isDrawer) Navigator.pop(context);
                    if(widget.isDrawer) Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchResult()
                      )
                    );
                  }
                  ),
            )
          ],
        ),
      ),
    );
  }

  Widget ListBox(List<dynamic> boxes) {
    return ListView.builder(
        padding: EdgeInsets.all(0),
        itemExtent: 33.0,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: boxes.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() => boxes[index]["chosen"] = value);
                  }
                },
                value: boxes[index]["chosen"],
              ),
              Expanded(
                child: Text(
                  "${boxes[index]["name"]}",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }


}

