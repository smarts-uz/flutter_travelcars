import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:http/http.dart' as http;


class TransfersAdd extends StatefulWidget {
  const TransfersAdd({Key? key}) : super(key: key);

  @override
  _TransfersAddState createState() => _TransfersAddState();
}

class _TransfersAddState extends State<TransfersAdd> {
  bool buttonIsLoading = false;
  final ScrollController _controller = ScrollController();

  final TextEditingController name_controller = TextEditingController();
  final TextEditingController price_controller = TextEditingController();
  bool logo_check = false;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  List<String> car = [];
  late final List<DropdownMenuItem<String>> cars;
  late List api_cars;
  String? chosen_car;
  int? car_model_id;


  List<String> directions = [
    '${LocaleKeys.meeting.tr()}',
    '${LocaleKeys.Drop_of.tr()}'
  ];
  int i = 1;
  List<String> city = [];
  late final List<DropdownMenuItem<String>> cities;
  late List api_cities;
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    getcities();
    getModels();
  }
  void getcities() {
    api_cities = HomeScreen.city_list;
    api_cities.forEach((element) {
      if(element["name"] != null) {
        city.add(element["name"]);
      }
    });
    cities = city.map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
      ),
    ).toList();
    data.add({
      "direction": 0,
      "city": city[0],
      "day": DateTime.now(),
      "time": TimeOfDay.now(),
      "controllers4": [
        for (int i = 0; i < 4; i++)
          TextEditingController()
      ],},
    );
  }

  void getModels() {
    api_cars = HomeScreen.carModels_list;
    chosen_car = api_cars[0]["name"];
    car_model_id = api_cars[0]["id"];
    api_cars.forEach((element) {
      car.add(element["name"]);
    });
    cars = car.map(
          (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
      ),
    ).toList();
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _showPicker(BuildContext cont) {
    showModalBottomSheet(
        context: cont,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(LocaleKeys.Photo_library.tr()),
                      onTap: () async {
                        final pickedImageFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        File file = File(pickedImageFile!.path);
                        setState(() {
                          _pickedImage = file;
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(LocaleKeys.Camera.tr()),
                    onTap: () async {
                      final pickedImageFile = await _picker.pickImage(
                        source: ImageSource.camera,
                      );
                      File file = File(pickedImageFile!.path);
                      setState(() {
                        _pickedImage = file;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.add_transfer.tr(),
          maxLines: 2,
          style: TextStyle(
            fontSize: 21,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .73,
            child: ListView.builder(
              controller: _controller,
                itemCount: i,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      margin:EdgeInsets.all(12),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.lightBlue,
                              maxRadius: 18,
                              child: Text(
                                "${index + 1}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [0, 1].map((int indexr) => Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width*.4,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Radio<int>(
                                        value: indexr,
                                        groupValue: data[index]["direction"],
                                        onChanged: (int? value) {
                                          if (value != null) {
                                            setState(() => data[index]["direction"] = value);
                                            print(value);
                                          }
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        directions[indexr],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              ).toList(),
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
                                  value: data[index]["city"],
                                  isExpanded: true,
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black
                                  ),
                                  underline: SizedBox(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      data[index]["city"] = newValue!;
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
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050),
                                ).then((pickedDate) {
                                  if(pickedDate==null)
                                  {
                                    return;
                                  }
                                  setState(() {
                                    data[index]["day"] = pickedDate;
                                  });
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${DateFormat('dd.MM.yyyy').format(data[index]["day"])}",
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    ),
                                    Icon(Icons.calendar_today),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final DateTime now = DateTime.now();
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
                                ).then((TimeOfDay? value) {
                                  if (value != null) {
                                    setState(() {
                                      data[index]["time"] = value;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${data[index]["time"].format(context)}",
                                      style: TextStyle(
                                        fontSize: 19
                                      ),
                                    ),
                                    Icon(Icons.timer_rounded),
                                  ],
                                ),
                              ),
                            ),
                            TFF(data[index]["controllers4"][0], "${LocaleKeys.Quantity_of_passengers.tr()}", 48, isNumber: true),
                            TFF(data[index]["controllers4"][1], "${LocaleKeys.From.tr()}", 48),
                            TFF(data[index]["controllers4"][2], "${LocaleKeys.To.tr()}", 48),
                            TFF(data[index]["controllers4"][3], "${LocaleKeys.note.tr()}", 110),
                          ]
                      ),
                    ),
                  );
                },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(i < 10) Container(
                  height: 35,
                  width: 140,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 5),
                        Text(
                          LocaleKeys.add.tr(),
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if(i <= 10) i++;
                      data.add({
                        "direction": 0,
                        "city": city[0],
                        "day": DateTime.now(),
                        "time": TimeOfDay.now(),
                        "controllers4": [
                          for (int i = 0; i < 4; i++)
                            TextEditingController()
                        ],
                      });
                      setState(() {

                      });

                      Future.delayed(const Duration(milliseconds: 500), () async {
                        _scrollDown();
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: Colors.orange
                        )
                    ),
                  ),
                ),
                if(i > 1) Container(
                  height: 35,
                  width: 140,
                  child: RaisedButton(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        SizedBox(width: 5),
                        Text(
                          LocaleKeys.delete.tr(),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    onPressed: (){
                      if(i > 1) {
                        data.removeAt(i-1);
                        i--;
                      }
                      setState(() {

                      }
                      );

                      Future.delayed(const Duration(milliseconds: 500), () async {
                        _scrollDown();
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: Colors.red
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Container(
                width: double.infinity,
                height: 45,
                padding: EdgeInsets.only(left: 6, right: 6),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)
                ),
                child:DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    menuMaxHeight: MediaQuery.of(context).size.height * .5,
                    dropdownColor: Colors.grey[50],
                    icon: Icon(Icons.keyboard_arrow_down),
                    value: chosen_car,
                    isExpanded: true,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        chosen_car = newValue;
                      });
                    },
                    items: cars,
                  ),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: TFF(price_controller, "${LocaleKeys.expectedPrice.tr()}(USD)", 45),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Row(
              children: [
                Checkbox(
                  onChanged: (bool? newValue) {
                    setState(() {
                      logo_check = newValue!;
                    });
                  },
                  value: logo_check,
                ),
                Expanded(
                  child: Text(
                    LocaleKeys.needPoster.tr(),
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                )
              ],
            ),
          ),
          if(logo_check) Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: TFF(name_controller, LocaleKeys.guestName.tr(), 45),
          ),
          if(logo_check) Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * .4,
                  margin: EdgeInsets.symmetric(vertical: 7.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image:   _pickedImage != null ?
                      DecorationImage(
                        image: FileImage(_pickedImage!),
                      ) : DecorationImage(
                          image: AssetImage("assets/images/no_image.png"))
                  ),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * .6,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * .5,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  LocaleKeys.upload.tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pickedImage = null;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * .5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: Colors.grey
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                size: 25,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 5),
                              Text(
                                LocaleKeys.delete.tr(),
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40)
              ),
              height: 40,
              width: MediaQuery.of(context).size.width*.70,
              child:  RaisedButton(
                  onPressed: () async {
                    setState(() {
                      buttonIsLoading = true;
                    });
                    FocusScope.of(context).unfocus();
                    final prefs = await SharedPreferences.getInstance();
                    if(prefs.containsKey("userData")) {
                      if(price_controller.text.isEmpty) {
                        ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}");
                        return;
                      }
                      if(logo_check) {
                        if(name_controller.text.isEmpty) {
                          ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}");
                          return;
                        }
                        if(_pickedImage == null) {
                          ToastComponent.showDialog("${LocaleKeys.no_image.tr()}");
                          return;
                        }
                      }
                      bool isValid = true;
                      List<Map<String, dynamic>> info = [];
                      data.forEach((element) {
                        int cityID = 0;
                        api_cities.forEach((cityid) {
                          if(cityid["name"] == element["city"]) {
                            cityID = cityid["city_id"];
                          }
                        });
                        info.add({
                          "from": "${element["controllers4"][1].text}",
                          "to": "${element["controllers4"][2].text}",
                          "type": element["direction"] == 0 ? "meeting" : "cunduct",
                          "city_id": "$cityID",
                          "date": "${DateFormat('dd.MM.yyyy').format(element["day"])}",
                          "time": "${element["time"].format(context).substring(0, 5)}",
                          "passengers": "${element["controllers4"][0].text}",
                          "additional": "${element["controllers4"][3].text}",
                        });
                      });

                      String empty_gap = " ";
                      info.forEach((element) {
                        element.forEach((key, value) {
                          if(value == "") {
                            empty_gap = key;
                            isValid = false;
                          }
                        });
                      });

                      api_cars.forEach((element) {
                        if(element["name"] == chosen_car) {
                          car_model_id = element["id"];
                        }
                      });

                      if(isValid) {
                        http.BaseRequest request;
                        String token = json.decode(prefs.getString('userData')!)["token"];
                        if(logo_check) {
                          request = http.MultipartRequest('POST', Uri.parse("${AppConfig.BASE_URL}/postTransfers"))
                            ..headers["Authorization"] = 'Bearer $token'
                            ..fields['transfers'] = "${json.encode(info)}"
                            ..fields['car_model_id'] = "$car_model_id"
                            ..fields['price'] = '${price_controller.text}'
                            ..fields['with_poster'] = '1'
                            ..fields['poster_name'] = '${name_controller.text}'
                            ..files.add(
                                await http.MultipartFile.fromPath(
                                    'poster_logo',
                                    '${_pickedImage?.path}',
                                    contentType: MediaType(
                                        'image', 'jpg'
                                    )
                                )
                            );
                        } else {
                          request = http.MultipartRequest('POST', Uri.parse("${AppConfig.BASE_URL}/postTransfers"))
                            ..headers["Authorization"] = 'Bearer $token'
                            ..fields['transfers'] = "${json.encode(info)}"
                            ..fields['car_model_id'] = "$car_model_id"
                            ..fields['price'] = '${price_controller.text}'
                            ..fields['with_poster'] = '0';
                        }
                        try{
                          var response = await request.send();
                          print(response.reasonPhrase);
                          print(response.statusCode);
                          if(response.statusCode == 200) {
                            Dialogs.ZayavkaDialog(context);
                          } else {
                            Dialogs.ErrorDialog(context);
                          }
                        } catch (error) {
                          print("Error: === $error");
                          Dialogs.ErrorDialog(context);
                        }
                      } else {
                        ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}: $empty_gap");
                      }
                    } else {
                      Dialogs.LoginDialog(context);
                    }
                    setState(() {
                      buttonIsLoading = false;
                    });
                  },
                  child: buttonIsLoading ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ) : Text(
                    LocaleKeys.submit_your_application.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  color: Colors.blue,
                ),
            ),
          ),
        ],
        ),
      ),
    );
  }
  Widget TFF(TextEditingController controller, String? hint, double height, {isNumber = false}) {
    return Container(
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: hint,
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
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 19
        ),
        expands: false,
        maxLines: height == 110 ? 7 : 2,
      ),
    );
  }
}
