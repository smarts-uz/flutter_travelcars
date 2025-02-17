import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:flutter_html/flutter_html.dart';

class TripItem extends StatefulWidget {
  final Map<String, dynamic> trip_item;

  TripItem(@required this.trip_item);

  @override
  _TripItemState createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {
  String token = "";
  String name = "";
  String phone = "";
  String email = "";
  TextEditingController comment_controller = new TextEditingController();



  List<TextEditingController> controllers = [
    for (int i = 0; i < 4; i++)
      TextEditingController()
  ];
  List<String> hints = [
    LocaleKeys.name.tr(),
    LocaleKeys.mail.tr(),
    LocaleKeys.phone.tr(),
    LocaleKeys.trip_comment.tr()
  ];

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('userData')) {
      token = json.decode(prefs.getString('userData')!)["token"] != null ? json.decode(prefs.getString('userData')!)["token"] : "";
      name = json.decode(prefs.getString('userData')!)["name"] != null ? json.decode(prefs.getString('userData')!)["name"] : "";
      phone = json.decode(prefs.getString('userData')!)["phone"] != null ? json.decode(prefs.getString('userData')!)["phone"] : "";
      email = json.decode(prefs.getString('userData')!)["email"] != null ? json.decode(prefs.getString('userData')!)["email"] : "";
      controllers[0] = new TextEditingController(text: name);
      controllers[1] = new TextEditingController(text: phone);
      controllers[2] = new TextEditingController(text: email);
    }

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          widget.trip_item["name"],
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
               height: MediaQuery.of(context).size.height * .3,
               width: double.infinity,
               padding: EdgeInsets.only(top: 20, left: 13, right: 13, bottom: 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "${AppConfig.image_url}/tours/${widget.trip_item["image"]}",
                    ),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {
                        Image.asset(
                          "assets/images/no_image.png",
                          fit: BoxFit.cover,
                        );
                      }
                  ),
                  //borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 13, left: 13),
              child: Text(
                widget.trip_item["name"],
                style: TextStyle(
                  fontSize: 27,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 4, left: 9),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.orange,
                    size: 22,
                  ),
                  Text(
                    widget.trip_item["content"],
                    style: TextStyle(
                      fontSize: 13
                    )
                  ),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 5, top: 9, right: 10),
              child: Html(
                data: widget.trip_item["region"],
                style: {
                  "table": Style(
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  "tr": Style(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  "th": Style(
                    padding: HtmlPaddings.all(6),
                    backgroundColor: Colors.grey,
                  ),
                  "td": Style(
                    padding: HtmlPaddings.all(6),
                    alignment: Alignment.topLeft,
                  ),
                  'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Color.fromRGBO(239, 127, 26, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 70,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    LocaleKeys.book_now.tr(),
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${LocaleKeys.We_will_be_glad_to_receive_your_order.tr()}!",
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white
                    ),
                  )
                ],
              ),
            ),
            /*Container(
              height: 180,
              width: double.infinity,
              padding: EdgeInsets.only(top: 15, left: 17, right: 17, bottom: 5),
              child: Stack(
                children: [
                  Container(
                    color: Color.fromRGBO(239, 127, 26, 1),
                  ),
                  Positioned(
                    top: 10,
                    left: 15,
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                  Positioned(
                      left: 17,
                      bottom: 40,
                      child: Text(
                        LocaleKeys.book_now.tr(),
                        style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.white
                        ),
                      )
                  ),
                  Positioned(
                      left: 17,
                      bottom: 10,
                      child: Text(
                        "${LocaleKeys.We_will_be_glad_to_receive_your_order.tr()}!",
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 15.0,
                            color: Colors.white
                        ),
                      )
                  )
                ],
              ),
            ),*/
            Column(
              children: [0, 1, 2, 3].map((e) => Container(
                width: double.infinity,
                height: e == 3 ? 145 : 45,
                padding: EdgeInsets.only(left: 15, right: 8),
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: TextFormField(
                  key: ValueKey(hints[e]),
                  keyboardType: e == 2 ? TextInputType.number : TextInputType.text,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    hintText: hints[e],
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  controller: controllers[e],
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: 17
                  ),
                  expands: false,
                  maxLines: e == 3 ? 6 : 1,
                ),
              ),).toList(),
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: Color.fromRGBO(0, 116, 201, 1), // Заменил color на backgroundColor
                  padding: EdgeInsets.all(8),
                ),
                child: Text(
                  LocaleKeys.send.tr(),
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Убедитесь, что цвет текста здесь
                  ),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  bool isValid = true;
                  Map<String, dynamic> info = {};

                  // Обработка информации
                  if (token.isEmpty) {
                    info = {
                      "name": controllers[0].text,
                      "email": controllers[1].text,
                      "phone": controllers[2].text,
                      "comment": controllers[3].text,
                      "tour_id": "${widget.trip_item["id"]}",
                    };
                  } else {
                    info = {
                      "name": name,
                      "email": email,
                      "phone": phone,
                      "comment": comment_controller.text,
                      "tour_id": "${widget.trip_item["id"]}",
                    };
                  }

                  // Проверка валидности
                  info.forEach((key, value) {
                    if (value == null || value.isEmpty) {
                      isValid = false;
                      ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()} $key");
                    }
                  });

                  print(info);
                  if (isValid) {
                    String url = "${AppConfig.BASE_URL}/tours/create";
                    try {
                      final result = await http.post(
                        Uri.parse(url),
                        body: info,
                      );
                      if (json.decode(result.body)["message"] == "Not found.") {
                        Dialogs.ErrorDialog(context);
                      } else {
                        print(result.body);
                        Dialogs.ZayavkaDialog(context);
                      }
                    } catch (error) {
                      print(error);
                      Dialogs.ErrorDialog(context);
                    }
                  }
                },
              ),

            )
          ],
        ),
      ),
    );
  }
}