import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final TextEditingController _phoneEmailController = TextEditingController();

  List<Map<String, dynamic>> data = [
    {"image": "Telegram", "check_box": false},
    {"image": "Whatsapp", "check_box": false},
    {"image": "Viber", "check_box": false},
    {"image": "Wechat", "check_box": false},
  ];

  @override
  void initState() {
    super.initState();
    getsocials();
  }

  void getsocials() async {
    int i = 2;
    final prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString('userData')!)["token"];
    String url = "${AppConfig.BASE_URL}/social";
    final result = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    Map<String, dynamic> socials = json.decode(result.body)["socials"];
    if(socials != null) {
      setState(() {
        socials.forEach((key, value) {
          data[i]["check_box"] = value == 0 ? false : true;
          i++;
          if(i==4) {
            i = 0;
          }
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        title: Text(
          SplashScreen.til == "uz" ? "Ижтимоий тармоқлар" : LocaleKeys.my_socials.tr(),
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontStyle: FontStyle.normal,
          ),
        ),
        titleSpacing: 0,
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
        child: Container(
          height: MediaQuery.of(context).size.height * 0.89,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                Text(
                  "${LocaleKeys.Select_social_network_through_which_we_can_contact_you.tr()}\n ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: data.map((item) => Column(
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
                          ),
                        ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.015,
                        ),
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
                    ).toList()),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String token = json.decode(prefs.getString('userData')!)["token"];
                    String url = "${AppConfig.BASE_URL}/social/update";
                    Map<String, dynamic> socials = {
                      "telegram": 0,
                      "whatsapp": 0,
                      "viber": 0,
                      "wechat": 0
                    };
                    socials["telegram"] = data[0]["check_box"] ? 1 : 0;
                    socials["whatsapp"] = data[1]["check_box"] ? 1 : 0;
                    socials["viber"] = data[2]["check_box"] ? 1 : 0;
                    socials["wechat"] = data[3]["check_box"] ? 1 : 0;

                    final result = await http.post(
                      Uri.parse(url),
                      headers: {
                        "Authorization": "Bearer $token",
                      },
                      body: {
                        "socials" : json.encode(socials)
                      }
                    );
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blue
                    ),
                    height: 40,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        LocaleKeys.save.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
