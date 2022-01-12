import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';

import '../../app_config.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final TextEditingController _phoneEmailController = TextEditingController();

  List<Map<String, dynamic>> data = [
    {"image": "viber", "check_box": false},
    {"image": "wechat", "check_box": false},
    {"image": "telegram", "check_box": false},
    {"image": "whatsapp", "check_box": false},
  ];

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
        title: Text(
          "Выбор Соц. Сетей",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.89,
          padding: const EdgeInsets.symmetric(horizontal: 16,),
          child: Column(
            children: [
              SizedBox(height: 35),
              Text(
                "Выберите социальную сеть, через которую мы можем с вами связаться",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: data
                      .map(
                        (item) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 64,
                              child: SvgPicture.asset("assets/images/${item["image"]}.svg"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                item["image"],
                                style: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Checkbox(
                                value: item["check_box"],
                                onChanged: (value) {
                                  setState(() {
                                    if (value != null)
                                      item["check_box"] = value;
                                  });
                                }),
                          ],
                        ),
                      )
                      .toList(),
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String token = jsonDecode(prefs.getString('userData')!)["token"];
                  Uri url = Uri.parse("${AppConfig.BASE_URL}/social/update");
                  Map<String, dynamic> socials = {
                    "telegram": 0,
                    "whatsapp": 0,
                    "viber": 0,
                    "wechat": 0
                  };
                  socials["viber"] = data[0]["check_box"] ? 1 : 0;
                  socials["wechat"] = data[1]["check_box"] ? 1 : 0;
                  socials["telegram"] = data[2]["check_box"] ? 1 : 0;
                  socials["whatsapp"] = data[3]["check_box"] ? 1 : 0;

                  final result = await http.post(
                      url,
                      headers: {
                        "Authorization": "Bearer $token",
                      },
                      body: {
                        "socials" : json.encode(socials)
                      }
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_)=> MainScreen()
                    ),
                    ModalRoute.withName('/'),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.orange
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width * .75,
                  child: Center(
                    child: Text(
                      LocaleKeys.confirm.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
