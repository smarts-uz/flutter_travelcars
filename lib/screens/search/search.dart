import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/search/search_result.dart';
import 'package:travelcars/screens/trip/trips.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class SearchScreen extends StatefulWidget {
  final bool isDrawer;
  SearchScreen({this.isDrawer=false});
  static String? SelectedVal1;
  static String? SelectedVal2;

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



  static DateTime? _selectedDate1 = DateTime.now();
  static DateTime? _selectedDate2 = DateTime.now();

  static var number_controller = TextEditingController();

  static List<dynamic> autoTypes = [];
  Map<String, dynamic> categories = {};
  List<dynamic> chosen_types = [];
  List<int> indexes = [];

  static List<dynamic> autoOptions = [];

  static List<dynamic> tarif = [];

  List<String> city = [];
  late final List<DropdownMenuItem<String>> cities;

  List<String> city_start = [];
  late final List<DropdownMenuItem<String>> cities_start;

  @override
  void initState() {
    super.initState();
    getcities();
    autoTypes = HomeScreen.cars_list;
    for(int i = 0; i < autoTypes.length; i++) {
      indexes.add(i);
    }
    categories = HomeScreen.category_list;
    autoOptions = HomeScreen.options_list;
    tarif = HomeScreen.tariff_list;
  }

  void getcities() {
    HomeScreen.city_list.forEach((element) {
      city.add(element["name"]);
    });
    cities = city.map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
      ),
    ).toList();

    HomeScreen.city_list.forEach((element) {
      if(!(element["city_id"] >= 20 && element["city_id"] <= 24)) {
        city_start.add(element["name"]);
      }
    });
    cities_start = city_start.map((String value) =>
        DropdownMenuItem<String>(
          value: value,
          child: Text(value),
      ),
    ).toList();
  }


  @override
  Widget build(BuildContext context) {
    /*double catHeight = 0;
    chosen_types = [];
    autoTypes.forEach((element) {
      if(element["chosen"]) {
        chosen_types.add(element);
        catHeight += categories["${element["name"]}"].length * 33.0 + 30.0;
      }
    });*/
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
                width: MediaQuery.of(context).size.width * .4,
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        directions[index],
                        textAlign: TextAlign.start,
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
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                  value: SearchScreen.SelectedVal1,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black
                  ),
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      SearchScreen.SelectedVal1 = newValue!;
                    });
                  },
                  items: cities_start,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                  value: SearchScreen.SelectedVal2,
                  isExpanded: true,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black
                  ),
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      SearchScreen.SelectedVal2 = newValue!;
                    });
                  },
                  items: cities,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
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
              child: Container(
                width: double.infinity,
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${DateFormat('dd/MM/yyyy').format(_selectedDate1!)}",
                      style: TextStyle(
                        fontSize: 19
                      ),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
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
              child: Container(
                width: double.infinity,
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${DateFormat('dd/MM/yyyy').format(_selectedDate2!)}",
                      style: TextStyle(
                        fontSize: 19
                      ),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
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
                  fontSize: 19
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
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                children: indexes.map((index) => Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          autoTypes[index]["chosen"] = !autoTypes[index]["chosen"];
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${autoTypes[index]["name"]}",
                            style: TextStyle(
                              fontSize: 19,
                            ),
                          ),
                           Icon(
                             autoTypes[index]["chosen"] ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                             size: 25,
                          ),
                        ],
                      ),
                    ),
                    autoTypes[index]["chosen"] ? SizedBox(
                        height: categories["${autoTypes[index]["meta_url"]}"].length * 33.0,
                        child: ListBox(categories["${autoTypes[index]["meta_url"]}"])
                    ) : SizedBox(height: 8,),
                  ],
                )).toList(),
              )
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15, bottom: 5, top: 10.0),
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
                    SearchScreen.SelectedVal1 = null;
                    SearchScreen.SelectedVal2 = null;
                    _currentRangeValues = RangeValues(50, 250);
                    _radioVal1 = null;
                    _radioVal2 = null;
                    autoTypes.forEach((element) {
                      element["chosen"] = false;
                    });
                    categories.forEach((key, value) {
                      value.forEach((element1) {
                        element1["chosen"] = false;
                      });
                    });
                    autoOptions.forEach((element) {
                      element["chosen"] = false;
                    });
                    tarif.forEach((element) {
                      element["chosen"] = false;
                    });
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
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    int city_start = 0;
                    int city_end = 0;
                    HomeScreen.city_list.forEach((element) {
                      if(element["name"] == SearchScreen.SelectedVal1) {
                        city_start = element["city_id"];
                      }

                      if(element["name"] == SearchScreen.SelectedVal2) {
                        city_end = element["city_id"];
                      }
                    });


                    Map<String, String> search_body = {
                      "reverse": "$_radioVal1",
                      "city_start": "$city_start",
                      "cities[]": "$city_end",
                      "date_start": "${DateFormat('dd.MM.yyyy').format(_selectedDate1!)}",
                      "date_end": "${DateFormat('dd.MM.yyyy').format(_selectedDate2!)}",
                      "passengers": "${number_controller.text}",
                      "s": _radioVal2 == 0 ? "price" : "places",
                      "price": "${_currentRangeValues.start.round()}+-+${_currentRangeValues.end.round()}",
                    };

                    print(search_body);
                    int ind1 = 0;
                    categories.forEach((key, value) {
                      value.forEach((element) {
                        if(element["chosen"]) {
                          search_body.addAll({
                             "car_models[$ind1]": "${element["id"]}",
                            });
                          ind1++;
                        }
                      });
                    });

                    ind1 = 0;
                    autoOptions.forEach((element) {
                      if(element["chosen"]) {
                        search_body.addAll({
                          "car_options[$ind1]": "${element["id"]}"
                        });
                        ind1++;
                      }
                    });

                    ind1 = 0;
                    tarif.forEach((element) {
                      if(element["chosen"]) {
                        search_body.addAll({
                          "route_options[$ind1]": "${element["id"]}"
                        });
                        ind1++;
                      }
                    });
                    int cityTour = -1;
                    if(city_end == 24) {
                      cityTour = city_start;
                    }

                    String? startCity = "";
                    String? endCity = "";
                    if(!(city_end >= 20 && city_end <= 24) && (SearchScreen.SelectedVal1 != null && SearchScreen.SelectedVal2 != null)) {
                      startCity = SearchScreen.SelectedVal1;
                      endCity = SearchScreen.SelectedVal2;
                    }

                    if(widget.isDrawer) Navigator.pop(context);
                    if(widget.isDrawer) Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResult(
                            search_body: search_body,
                            cityTour: cityTour,
                            CityStart: startCity,
                            CityEnd: endCity,
                          )
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

