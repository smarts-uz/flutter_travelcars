import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_theme.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final TextEditingController _phoneEmailController = TextEditingController();

  List<Map<String, dynamic>> data = [
    {"image": "assets/wechat.svg", "check_box": false},
    {"image": "assets/viber.svg", "check_box": false},
    {"image": "assets/whatsapp.svg", "check_box": false},
    {"image": "assets/telegram.svg", "check_box": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        title: Text(
          "Соц. сети для связи",
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontStyle: FontStyle.normal,
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
                    children: data
                        .map(
                          (item) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 64,
                                child: SvgPicture.asset(item["image"]),
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
                        )
                        .toList()),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Введите номер телефона",
                      hintText: "+998(__) ___ __ __",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.blue),
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
