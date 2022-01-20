import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

import '../../app_config.dart';

import 'package:http/http.dart' as http ;

import '../../dialogs.dart';

class FeedbackScreen extends StatefulWidget {
  final int route_price_id;
  FeedbackScreen(this.route_price_id);


  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  DateTime? _selectedDate2 = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  String? country;
  late final List<DropdownMenuItem<String>> countries;
  List<String> api_countries = [];

  String token = "";
  int user_id = 0;

  Map<String, dynamic> rate =
  {
    'driver': [
      {
        "title": LocaleKeys.punctuality.tr(),
        "rating": 0
      },
      {
        "title": LocaleKeys.car_driving.tr(),
        "rating": 0
      },
      {
        "title": LocaleKeys.knowledge_of_traffic.tr(),
        "rating": 0
      },
      {
        "title": LocaleKeys.Terrain_orientation.tr(),
        "rating": 0
      },
      {
        "title": LocaleKeys.Knowledge_of_the_language.tr(),
        "rating": 0
      },
    ],

    'car':[
      {
        "title": LocaleKeys.Cleanliness_smell_in_the_cabin.tr(),
        "rating": 0
      },
      {
        "title": LocaleKeys.Amenities_in_the_salon.tr(),
        "rating": 0
      },
    ],

    'all':[
      {
        "title": LocaleKeys.Level_of_professionalism_of_the_driver.tr(),
        "rating": 0
      },
      {
        "title": LocaleKeys.Price_quality_ratio.tr(),
        "rating": 0
      },
    ]
  };

  @override
  void initState() {
    super.initState();
    HomeScreen.countries_list.forEach((element){
      SplashScreen.til == "en" ? api_countries.add(element["country_name"]) : api_countries.add(element["country_name_ru"]);
    });
    countries = api_countries.map((String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      ),
    ).toList();
    getToken();
  }

  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = json.decode(prefs.getString('userData')!)["token"] != null ? json.decode(prefs.getString('userData')!)["token"] : "";
    user_id = json.decode(prefs.getString('userData')!)["user_id"] != null ? json.decode(prefs.getString('userData')!)["user_id"] : "";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
        backgroundColor: Colors.orange,
        title: Text(
          LocaleKeys.write_feedback.tr(),
          style: TextStyle(
            fontSize: 25,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            if(token.isEmpty) Container(
              width: double.infinity,
              height: 45,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15),
              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  hintText: "${LocaleKeys.name.tr()}",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  hintMaxLines: 3,
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
                controller: _nameController,
                keyboardType: TextInputType.name,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: HexColor('#3C3C43')),
                expands: false,
                maxLines: 2,
              ),
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  menuMaxHeight: MediaQuery.of(context).size.height * .5,
                  hint: Text(
                     LocaleKeys.country.tr(),
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black
                      )
                  ),
                  dropdownColor: Colors.grey[50],
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: country,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                  ),
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      country = newValue!;
                    });
                  },
                  items: countries,
                ),
              ),
            ),
            if(widget.route_price_id < 0) Container(
              width: double.infinity,
              height: 45,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    hintText: "Название маршрута",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    hintMaxLines: 3,
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
                  controller: _routeController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: HexColor('#3C3C43'),
                  ),
                  expands: false,
                  maxLines: 2,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2018),
                  lastDate: DateTime.now(),
                ).then((pickedDate) {
                  if (pickedDate == null) {
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${DateFormat('dd/MM/yyyy').format(_selectedDate2!)}",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            _text(text: "${LocaleKeys.driver.tr()}:"),
            _list(rate['driver']),
            _text(text: "${LocaleKeys.car.tr()}:"),
            _list(rate['car']),
            _text(text: "${LocaleKeys.overall_score.tr()}:"),
            _list(rate['all']),
            _text(text: "${LocaleKeys.leave_feedback.tr()} :"),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.3,
              padding: EdgeInsets.only(left: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: TextFormField(
                maxLines: 10,
                autovalidateMode: AutovalidateMode.always,
                decoration:  InputDecoration(
                    hintText: "${LocaleKeys.write_feedback.tr()}...",
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
                controller: _commentController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: 18
                ),
                expands: false,
              ),
            ),
            InkWell(
              onTap: () async {
                FocusScope.of(context).unfocus();
                if ((token.isEmpty && _nameController.text.isEmpty)
                      || _commentController.text.isEmpty
                        || country == null
                          || (widget.route_price_id < 0 && _routeController.text.isEmpty)
                ) {
                  ToastComponent.showDialog(LocaleKeys.TextField_is_empty.tr(), );
                  return;
                }

                bool noStar = false;
                rate.forEach((key, value) {
                  value.forEach((element) {
                    if(element["rating"] == 0) {
                      print(element);
                      noStar = true;
                    }
                  });
                });
                if(noStar) {
                  ToastComponent.showDialog(LocaleKeys.TextField_is_empty.tr());
                  return;
                }

                Uri url = Uri.parse("${AppConfig.BASE_URL}/comment/create");
                Map<String, dynamic> comment = {
                 "rules": "${rate['driver'][2]["rating"]}",
                 "salon": "${rate['car'][1]['rating']}",
                 "driving": "${rate['driver'][1]['rating']}",
                 "language": "${rate['driver'][4]['rating']}",
                 "Cleanliness": "${rate['car'][0]['rating']}",
                 "Punctuality": "${rate['driver'][0]['rating']}",
                 "orientation": "${rate['driver'][3]['rating']}",
                 "Price_quality": "${rate['all'][1]['rating']}",
                 "professionalism": "${rate['all'][0]['rating']}"
                };

                String countryCode = "UZ";
                HomeScreen.countries_list.forEach((element) {
                  if(element["country_name"] == country) {
                    countryCode = element["country_code"];
                  }
                });
                print("user id: " + user_id.toString());
                try {
                  final result = await http.post(
                      url,
                      headers: {
                        "Authorization": "Bearer $token",
                      },
                      body: {
                        if(token.isEmpty) "name": _nameController.text,
                        if(token.isNotEmpty) "user_id": "${user_id}",
                        "country_code": countryCode,
                        if(widget.route_price_id < 0) "route_name": _routeController.text,
                        if(widget.route_price_id >= 0) "route_price_id": "${widget.route_price_id}",
                        "route_date" : "${DateFormat('dd.MM.yyyy').format(_selectedDate2!)}",
                        "grade" : "${json.encode(comment)}",
                        "text" : _commentController.text,
                      });
                  print(widget.route_price_id);
                  print(result.body);
                  Dialogs.OtzivDialog(context);
                } catch (error) {
                  print(error);
                  Dialogs.ErrorDialog(context);
                }
              },
              child: Container(
                margin: EdgeInsets.all(16),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                      LocaleKeys.post_reviews.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text({text}) {
    return Container(
      padding: EdgeInsets.only(left: 16,top: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
  Widget _list (List given){
    return Container(
      height: given.length * 73,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: given.length,
        itemBuilder: (context, index) => Container(
          height: 73,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 16, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  given[index]["title"],
                  style: TextStyle(
                    fontSize: 17
                  ),
                ),
              ),
              FittedBox(
                child: RatingBar.builder(
                  maxRating: 10,
                  itemCount: 10,
                  itemSize: 35,
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rate_outlined,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) => {
                    setState(() {
                      given[index]["rating"] = rating;
                      },
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
