import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/feedback/components/drop_button_city.dart';

import '../../app_config.dart';
import '../../app_theme.dart';
import 'package:http/http.dart' as http ;

import '../../dialogs.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);


  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  DateTime? _selectedDate2 = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  Map<String, dynamic> rate =
  {
    'driver': [
      {
        "title": "Пунктуальность",
        "rating": 0
      },
      {
        "title": "Вождение автомобиля",
        "rating": 0
      },
      {
        "title": "Знание ПДД",
        "rating": 0
      },
      {
        "title": "Ориентировка на местность",
        "rating": 0
      },
      {
        "title": "Знание языка",
        "rating": 0
      },
    ],

    'car':[
      {
        "title": "Чистота/запах в салоне",
        "rating": 0
      },
      {
        "title": "Удобства в салоне",
        "rating": 0
      },
    ],

    'all':[
      {
        "title": "Профессионализм водителя",
        "rating": 0
      },
      {
        "title": "Соотношение цена/качество",
        "rating": 0
      },
    ]
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.orange,
        title: Text("Написать отзыв",
          style:TextStyle(
        fontSize: 17,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        color: Colors.white,),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  hintText: "Имя",
                ),
                controller: _nameController,
                keyboardType: TextInputType.name,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: 17,
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
              height: 55,
              padding: EdgeInsets.only(left: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                  hintText: "City",
                ),
                controller: _cityController,
                keyboardType: TextInputType.name,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: 17,
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
              height: 55,
              padding: EdgeInsets.only(left: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(
                    hintText: "Название маршрута",
                  ),
                  controller: _routeController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 17,
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
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.only(left: 6),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
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
                      if (pickedDate == null) {
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
            _text(text: "Водитель:"),
            _list(rate['driver']),
            _text(text: "Автомобиль:"),
            _list(rate['car']),
            _text(text: "Общая оценка:"),
            _list(rate['all']),
            _text(text: "Оставить отзыв"),
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
                maxLines: 7,
                autovalidateMode: AutovalidateMode.always,
                decoration: const InputDecoration(
                    hintText: "Напишите отзыв...",
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
                    fontSize: 20
                ),
                expands: false,
              ),
            ),
            GestureDetector(
              onTap: () {

                for(int j = 0; j<rate["driver"].length;  j++){
                  print("Driver item rate ${rate["driver"][j]["rating"]}");
                }
                for(int j = 0; j<rate["car"].length;  j++){
                  print("Car item rate ${rate["car"][j]["rating"]}");
                }
                for(int j = 0; j<rate["all"].length;  j++){
                  print("All item rate ${rate["all"][j]["rating"]}");
                }

              },
              child: InkWell(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  bool isValid = true;
                  String url = "${AppConfig.BASE_URL}/comment/create";
                  Map<String, dynamic> comment = {
                   "rules": "${rate['driver'][2]["rating"]}",
                   "salon": "${rate['car'][1]['rating']}",
                   "driving": "${rate['driver'][1]['rating']}",
                   "language": "${rate['driver'][4]['rating']}",
                   "Cleanliness": "${rate['car'][0]['rating']}",
                   "Punctuality": "${rate['driver'][0]['rating']}",
                   "orientation": "${rate['driver'][3]['rating']}",
                   "Price_quality": "${rate['all'][1]['rating']}",
                   "professionalism": "${rate['all'][0]['rating']}"};
                 comment.forEach((key, value) {
                   if(value == null || value == "0"){
                     isValid = false;
                     print("write$key");
                   }
                 });
                 if(_commentController.text == "") isValid = false;
                 if(_nameController.text == "") isValid = false;
                 if(_cityController.text == "") isValid = false;
                 if(isValid){
                   try {
                     final prefs = await SharedPreferences.getInstance();
                     String token = json.decode(prefs.getString('userData')!)["token"];
                     final result = await http.post(
                         Uri.parse(url),
                         headers: {
                           "Authorization": "Bearer $token",
                         },
                         body: {
                           "text" : _commentController.text,
                           "route_id" : '0',
                           "route_name": _nameController.text,
                           "country_code" : _cityController.text,
                           "route_date" : "${DateFormat('dd.MM.yyyy').format(_selectedDate2!)}",
                           "grade" : "${json.encode(comment)}"
                         }
                     );
                     print(json.decode(result.body)['message']);
                     Dialogs.OtzivDialog(context);
                   } catch (error) {
                     Dialogs.ErrorDialog(context);
                   }}
                 },
                child: Container(
                  margin: EdgeInsets.all(16),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: MyColor.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      "Отправить отзыв",
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
          fontSize: 19,
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
      height: given.length*80,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: given.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.only(left: 8, bottom: 5, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                    given[index]["title"],

                ),//rate['driver'][index]["title"]
              ),
              Container(
                width: double.infinity,
                child: RatingBar.builder(
                  maxRating: 10,
                  itemCount: 10,
                  //unratedColor: Colors.amber.withAlpha(50),
                  itemSize: 35,
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rate_outlined,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) => {
                    setState(
                          () {
                            given[index]["rating"] = rating;
                            //print(rating);
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
