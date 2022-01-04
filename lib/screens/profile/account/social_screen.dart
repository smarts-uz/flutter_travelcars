import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/app_config.dart';
import 'package:http/http.dart' as http;

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final TextEditingController _phoneEmailController = TextEditingController();

  List<Map<String, dynamic>> data = [
    {"image": "viber", "check_box": false},
    {"image": "wechat", "check_box": false},
    {"image": "telegram", "check_box": false},
    {"image": "whatsapp", "check_box": false},
  ];

  @override
  void initState() {
    super.initState();
    getsocials();
  }

  void getsocials() async {
    int i = 0;
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
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text(
          "Соц. сети для связи",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontStyle: FontStyle.normal,
          ),
        ),
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
                  "Выберите социальную сеть, через\n которую мы можем с вами связаться",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
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
                    socials["viber"] = data[0]["check_box"] ? 1 : 0;
                    socials["wechat"] = data[1]["check_box"] ? 1 : 0;
                    socials["telegram"] = data[2]["check_box"] ? 1 : 0;
                    socials["whatsapp"] = data[3]["check_box"] ? 1 : 0;

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
                        "Сохранить",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
