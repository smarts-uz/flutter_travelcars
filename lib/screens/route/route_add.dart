import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import '../../app_config.dart';

class RouteAdd extends StatefulWidget {
  const RouteAdd({Key? key}) : super(key: key);

  @override
  _RouteAddState createState() => _RouteAddState();
}

class _RouteAddState extends State<RouteAdd> {
  final ScrollController _controller = ScrollController();

  final TextEditingController name_controller = TextEditingController();
  final TextEditingController additional_controller = TextEditingController();
  final TextEditingController price_controller = TextEditingController();
  bool logo_check = false;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  List<String> car = [];
  late final List<DropdownMenuItem<String>> cars;
  late List api_cars;
  String? chosen_car;
  int? car_type_id;

  List<String> city = [];
  late final List<DropdownMenuItem<String>> cities;
  late List api_cities;
  int count = 1;
  List<Map<String, dynamic>> data = [];
  @override
  void initState() {
    super.initState();
    getcities();
    getCars();
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
      "city1": city[0],
      "city2": city[0],
      "day": DateTime.now(),
      "controllers2": [
        for (int i = 0; i < 2; i++)
          TextEditingController()
      ],
    },);
  }

  void getCars() {
    api_cars = HomeScreen.carModels_list;
    chosen_car = api_cars[0]["name"];
    car_type_id = api_cars[0]["id"];
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
          LocaleKeys.add_route.tr(),
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21
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
              height: 430,
              child: ListView.builder(
                controller: _controller,
                itemCount: count,
                itemBuilder: (context, index) {
                  Widget DDM (bool isCity1, String? hint) {
                    return Container(
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
                          hint: Text(
                              hint!,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black
                              )
                          ),
                          dropdownColor: Colors.grey[50],
                          icon: Icon(Icons.keyboard_arrow_down),
                          value: isCity1 ? data[index]["city1"] : data[index]["city2"],
                          isExpanded: true,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                          underline: SizedBox(),
                          onChanged: (String? newValue) {
                            setState(() {
                              isCity1 ? data[index]["city1"] = newValue! : data[index]["city2"] = newValue!;
                            });
                          },
                          items: cities,
                        ),
                      ),
                    );
                  }
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(24, 24, 24, 5),
                    child:Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      margin:EdgeInsets.all(13),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text('${LocaleKeys.trip_mapp.tr()} ${index + 1}',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            DDM(true, "${LocaleKeys.From.tr()}"),
                            DDM(false, "${LocaleKeys.To.tr()}"),
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
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                                          fontSize: 19
                                      ),
                                    ),
                                    Icon(Icons.calendar_today),
                                  ],
                                ),
                              ),
                            ),
                            TFF("${LocaleKeys.Quantity_of_passengers.tr()}", data[index]["controllers2"][0], 48, isNumber: true),
                            TFF("${LocaleKeys.The_address_of_the_place_to_pick_up_from.tr()}", data[index]["controllers2"][1], 110),
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
                  if(count < 10) Container(
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
                        if(count <= 10) count++;
                        data.add({
                          "city1": city[0],
                          "city2": city[0],
                          "day": DateTime.now(),
                          "controllers2": [
                            for (int i = 0; i < 2; i++)
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
                  if(count > 1) Container(
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
                                fontSize: 15
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        if(count > 1) {
                          data.removeAt(count-1);
                          count--;
                        }
                        setState(() {

                        });

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
              child: TFF("${LocaleKeys.expectedPrice.tr()}(USD)", price_controller, 45),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: TFF(LocaleKeys.additional_info.tr(), additional_controller, 120),
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
              child: TFF(LocaleKeys.guestName.tr(), name_controller, 45),
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
              padding: const EdgeInsets.only(bottom: 13.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4)
                ),
                height: 40,
                width: MediaQuery.of(context).size.width * .70,
                child: RaisedButton(
                  onPressed: () async {
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
                        api_cities.forEach((cityid) {
                          if(cityid["name"] == element["city1"]) {
                            element["city1"] = cityid["city_id"];
                          }
                          if(cityid["name"] == element["city2"]) {
                            element["city2"] = cityid["city_id"];
                          }
                        });
                        info.add({
                          "from": "${element["city1"]}",
                          "to": "${element["city2"]}",
                          "date": "${DateFormat('dd-MM-yyyy').format(element["day"])}",
                          "passengers": "${element["controllers2"][0].text}",
                          "address": "${element["controllers2"][1].text}",
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
                          car_type_id = element["id"];
                        }
                      });

                      if(isValid) {
                        int ind = 0;
                        data.forEach((element_info) {
                          api_cities.forEach((element_city) {
                            setState(() {
                              if(element_info["city1"] == element_city["city_id"]) {
                                data[ind]["city1"] = element_city["name"];
                              }
                              if(element_info["city2"] == element_city["city_id"]) {
                                data[ind]["city2"] = element_city["name"];
                              }
                            });
                          });
                          ind++;
                        });
                        http.BaseRequest request;
                        String token = json.decode(prefs.getString('userData')!)["token"];
                        if(logo_check) {
                          request = http.MultipartRequest('POST', Uri.parse("${AppConfig.BASE_URL}/custom/booking/create"))
                            ..headers["Authorization"] = 'Bearer $token'
                            ..fields['data'] = "${json.encode(info)}"
                            ..fields['car_model_id'] = "$car_type_id"
                            ..fields['additional'] = '${additional_controller.text}'
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
                          request = http.MultipartRequest('POST', Uri.parse("${AppConfig.BASE_URL}/custom/booking/create"))
                            ..headers["Authorization"] = 'Bearer $token'
                            ..fields['data'] = "${json.encode(info)}"
                            ..fields['car_model_id'] = "$car_type_id"
                            ..fields['additional'] = '${additional_controller.text}'
                            ..fields['price'] = '${price_controller.text}'
                            ..fields['with_poster'] = '0';
                        }
                        try{
                          var response = await request.send();
                          print(response.reasonPhrase);
                          print(response.statusCode);
                          if(response.statusCode == 200) {
                            List<Map<String, String>> routes = [];
                            data.forEach((element) {
                              routes.add({
                                "from": element["city1"],
                                "to": element["city2"],
                                "date": "${DateFormat('dd-MM-yyyy').format(element["day"])}",
                              });
                            });
                            Dialogs.TripDialog(context, routes);
                          } else {
                            Dialogs.ErrorDialog(context);
                          }
                        } catch (error) {
                          print("Error: === $error");
                          Dialogs.ErrorDialog(context);
                        }

                      } else {
                        int ind = 0;
                        data.forEach((element_info) {
                          api_cities.forEach((element_city) {
                            setState(() {
                              if(element_info["city1"] == element_city["city_id"]) {
                                data[ind]["city1"] = element_city["name"];
                              }
                              if(element_info["city2"] == element_city["city_id"]) {
                                data[ind]["city2"] = element_city["name"];
                              }
                            });
                          });
                          ind++;
                        });
                        ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}: $empty_gap");
                      }
                    } else {
                      Dialogs.LoginDialog(context);
                    }
                  },
                  child: Text(
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

  Widget TFF (String? hint_text, TextEditingController controller, double height, {bool isNumber = false}) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.only(left: 8),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: hint_text,
          hintMaxLines: 3,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 18
        ),
        expands: false,
        maxLines: 7,
      ),
    );
  }
}



