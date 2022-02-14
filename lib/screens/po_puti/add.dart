import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/dialogs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/po_puti/po_puti.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class AddScreen extends StatefulWidget {
  final Map<String, dynamic> way_item;

  AddScreen({this.way_item = const {}});

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool buttonIsLoading = false;
  DateTime day = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  List text_controllers =  [];


  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String? image;

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
  void initState() {
    super.initState();
    image = widget.way_item["image"];
    if(widget.way_item.isNotEmpty) {
      text_controllers.add(TextEditingController(text: widget.way_item["address1"]));
      text_controllers.add(TextEditingController(text: widget.way_item["address2"]));
      //kevotti 29.01.2022
      //kerak 2020-01-02
      String a = widget.way_item["date"];
      String dayParse = "${a.substring(6, 10)}-${a.substring(3, 5)}-${a.substring(0, 2)}";
      day = DateTime.parse(dayParse);
      time = TimeOfDay(hour:int.parse(widget.way_item["time"].split(":")[0]),minute: int.parse(widget.way_item["time"].split(":")[1]));
      text_controllers.add(TextEditingController(text: widget.way_item["model_car"]));
      text_controllers.add(TextEditingController(text: widget.way_item["place_bag"]));
      text_controllers.add(TextEditingController(text: widget.way_item["place"]));
      text_controllers.add(TextEditingController(text: widget.way_item["name"]));
      text_controllers.add(TextEditingController(text: widget.way_item["tel"]));
      text_controllers.add(TextEditingController(text: widget.way_item["comment"]));
    } else {
      text_controllers = [
        for (int i = 0; i < 8; i++)
          TextEditingController()
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.way_item.isNotEmpty ? LocaleKeys.edit_advert.tr() : LocaleKeys.Create_advert.tr(),
          maxLines: 3,
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
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            margin:EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TFF("${LocaleKeys.From.tr()}", text_controllers[0], 48, false),
                TFF("${LocaleKeys.To.tr()}", text_controllers[1], 48, false),
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
                        day = pickedDate;
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
                          "${DateFormat('dd.MM.yyyy').format(day)}",
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
                    final DateTime now = DateTime.now();
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
                    ).then((TimeOfDay? value) {
                      if (value != null) {
                        setState(() {
                          time = value;
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
                          "${time.format(context)}",
                          style: TextStyle(
                            fontSize: 19
                          ),
                        ),
                        Icon(Icons.timer_rounded),
                      ],
                    ),
                  ),
                ),
                TFF("${LocaleKeys.Car_type.tr()}", text_controllers[2], 48, false),
                TFF("${LocaleKeys.Quantity_.tr()}", text_controllers[3], 48, true),
                TFF("${LocaleKeys.Quantity.tr()}", text_controllers[4], 48, true),
                TFF("${LocaleKeys.name_surname.tr()}", text_controllers[5], 48, false),
                TFF("${LocaleKeys.phone.tr()}", text_controllers[6], 48, true),
                TFF("${LocaleKeys.enRoute_note.tr()}", text_controllers[7], 110, false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * .4,
                      margin: EdgeInsets.symmetric(vertical: 7.0),//MediaQuery.of(context).size.width * .2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image:   _pickedImage != null ?
                        DecorationImage(
                          image: FileImage(_pickedImage!),
                        ) : image != null ? DecorationImage(
                          image: NetworkImage(
                              "${AppConfig.image_url}/Onways/${widget.way_item["image"]}"
                          ),
                            onError: (error, stackTrace) {
                              Image.asset(
                                "assets/images/no_car.jpg",
                                fit: BoxFit.cover,
                              );
                            }
                        ) : DecorationImage(
                            image: AssetImage("assets/images/no_car.jpg")
                        )
                      ),
                    ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * .4,
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  height: MediaQuery.of(context).size.height * .045,
                  width: MediaQuery.of(context).size.width * .8,
                  child:  RaisedButton(
                    onPressed: () async {
                      setState(() {
                        buttonIsLoading = true;
                      });
                      FocusScope.of(context).unfocus();
                      for(int i = 0; i< text_controllers.length; i++) {
                        if(text_controllers[i].text == null || text_controllers[i].text == "") {
                          ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}: $i");
                          return;
                        }
                      }
                      if(_pickedImage == null && widget.way_item.isEmpty) {
                        ToastComponent.showDialog(LocaleKeys.no_image.tr());
                        return;
                      }
                      final prefs = await SharedPreferences.getInstance();
                      int user_id = jsonDecode(prefs.getString("userData")!)["user_id"];
                      String token = jsonDecode(prefs.getString("userData")!)["token"];
                      Uri url_add = Uri.parse("${AppConfig.BASE_URL}/createWay");
                      Uri url_edit = Uri.parse("${AppConfig.BASE_URL}/onway/edit");
                      http.BaseRequest request;
                      if(_pickedImage != null) {
                        request = http.MultipartRequest('POST', widget.way_item.isEmpty ? url_add : url_edit)
                          ..headers["Authorization"] = widget.way_item.isNotEmpty ? 'Bearer $token' : ''
                          ..fields['address1'] = '${text_controllers[0].text}'
                          ..fields['address2'] = '${text_controllers[1].text}'
                          ..fields['date'] = '${DateFormat('yyyy-MM-dd').format(day)}'
                          ..fields['time'] = '${time.format(context)}'
                          ..fields['model'] = '${text_controllers[2].text}'
                          ..fields['place'] = '${text_controllers[3].text}'
                          ..fields['place_bag'] = '${text_controllers[4].text}'
                          ..fields['name'] = '${text_controllers[5].text}'
                          ..fields['tel'] = '${text_controllers[6].text}'
                          ..fields['comment_text'] = '${text_controllers[7].text}'
                          ..fields['user_id'] = '$user_id'
                          ..fields['id'] = '${widget.way_item["id"] ?? "0"}'
                          ..files.add(
                              await http.MultipartFile.fromPath(
                                  'image',
                                  '${_pickedImage?.path}',
                                  contentType: MediaType(
                                      'image', 'jpg'
                                  )
                              )
                          );
                      } else {
                        request = http.MultipartRequest('POST', url_edit)
                          ..headers["Authorization"] = 'Bearer $token'
                          ..fields['address1'] = '${text_controllers[0].text}'
                          ..fields['address2'] = '${text_controllers[1].text}'
                          ..fields['date'] = '${DateFormat('yyyy-MM-dd').format(day)}'
                          ..fields['time'] = '${time.format(context)}'
                          ..fields['model'] = '${text_controllers[2].text}'
                          ..fields['place'] = '${text_controllers[3].text}'
                          ..fields['place_bag'] = '${text_controllers[4].text}'
                          ..fields['name'] = '${text_controllers[5].text}'
                          ..fields['tel'] = '${text_controllers[6].text}'
                          ..fields['comment_text'] = '${text_controllers[7].text}'
                          ..fields['id'] = '${widget.way_item["id"]}';
                      }
                      try{
                        var response = await request.send();
                        print(response.reasonPhrase);
                        if (response.statusCode == 200) {
                          if(widget.way_item.isNotEmpty) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) =>PoPutiScreen()
                                )
                            );
                          } else {
                            Dialogs.PoPutiDialog(context);
                          }
                        }
                      } catch (e) {
                        print(e);
                        Dialogs.ErrorDialog(context);
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
                      widget.way_item.isNotEmpty ? LocaleKeys.save.tr() : LocaleKeys.send.tr(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TFF (String? hintText, TextEditingController controller, double height, bool isNumber) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18
          ),
          hintMaxLines: 3,
        ),
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none
        ),
        expands: false,
        maxLines: 7,
      ),
    );
  }
}
