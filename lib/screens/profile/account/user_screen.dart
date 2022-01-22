import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

import '../../../app_config.dart';


class FirstSceen extends StatefulWidget {
  @override
  _FirstSceenState createState() => _FirstSceenState();
}

class _FirstSceenState extends State<FirstSceen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  List<String> sort = [
    LocaleKeys.fizik.tr(),
    LocaleKeys.yuridik.tr(),
   ];
  int? _radioVal2;
  List<TextEditingController> controllers = [
    for (int i = 0; i < 10; i++)
      TextEditingController()
  ];
  List<String> hints = [
    LocaleKeys.yur_name.tr(),
    LocaleKeys.yur_city.tr(),
    LocaleKeys.yur_pochta.tr(),
    LocaleKeys.yur_bank.tr(),
    LocaleKeys.yur_account.tr(),
    LocaleKeys.oked.tr(),
    LocaleKeys.mfo.tr(),
    LocaleKeys.inn.tr(),
    LocaleKeys.okenh.tr(),
  ];

  Map<String, dynamic> userinfo = {};
  Map<String, dynamic> companyinfo = {};

  @override
  void initState() {
    super.initState();
    getuserdata();
    getcompanydata();
  }

  void getuserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userinfo = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      _emailController = TextEditingController(text: userinfo["email"]);
      _nameController = TextEditingController(text: userinfo["name"]);
      _phoneController = TextEditingController(text: userinfo["phone"]);
      _radioVal2 = userinfo["shaxs"] == "individual" ? 0 : 1;
    });
  }
  void getcompanydata() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("companyData")) {
      int i = 0;
      setState(() {
        companyinfo = json.decode(prefs.getString('companyData')!) as Map<String, dynamic>;
        companyinfo.forEach((key, value) {
          controllers[i] = TextEditingController(text: value);
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
        title: Text(
          LocaleKeys.Change_profile.tr(),
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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .81,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget> [
                    Container(
                      padding: EdgeInsets.only(top: 35, right: 16, left: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.5),
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            child: TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: LocaleKeys.name.tr(),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 45,
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: LocaleKeys.phone.tr(),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 45,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: LocaleKeys.mail.tr(),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [0, 1].map((int index) =>
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 35,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Radio<int>(
                                          value: index,
                                          groupValue: _radioVal2,
                                          onChanged: (int? value) {
                                            if (value != null) {
                                              setState(() => this
                                                  ._radioVal2 = value);
                                            }
                                            },
                                        ),
                                        Text(
                                          sort[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ).toList(),
                            ),
                          ),
                          if (_radioVal2 == 1) Column(
                            children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].map((e) => Container(
                              width: double.infinity,
                              height:  45,
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                decoration: InputDecoration(
                                  labelText: hints[e],
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
                                controller: controllers[e],
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 15
                                ),
                                expands: false,
                              ),
                            ),).toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (ctx) {
                return GestureDetector(
                  onTap: () async {
                    bool isValid = true;
                    Map<String, String> newData;
                    if(_emailController.text.isEmpty ||
                        _nameController.text.isEmpty ||
                        _phoneController.text.isEmpty) isValid = false;
                    if(_radioVal2 == 0) {
                      newData = {
                        "email": _emailController.text,
                        "name": _nameController.text,
                        "phone": _phoneController.text,
                        "personality": "individual",
                      };
                    } else {
                      controllers.forEach((element) {
                        if(element.text.isEmpty) {
                          isValid = false;
                        }
                      });
                      newData = {
                        "email": _emailController.text,
                        "name": _nameController.text,
                        "phone": _phoneController.text,
                        "personality": "legal",
                        "company_name": controllers[0].text,
                        "city": controllers[1].text,
                        "address": controllers[2].text,
                        "post": controllers[3].text,
                        "bank": controllers[4].text,
                        "bank_account": controllers[5].text,
                        "oked": controllers[6].text,
                        "mfo": controllers[7].text,
                        "inn": controllers[8].text,
                        "okonh": controllers[9].text,
                      };
                    }
                    if(isValid) {
                      try{
                        final pref = await SharedPreferences.getInstance();
                        String token = json.decode(pref.getString('userData')!)["token"];
                        Uri url = Uri.parse("${AppConfig.BASE_URL}/user/update");
                        final result = await http.post(
                            url,
                            headers: {
                              "Authorization": "Bearer $token",
                            },
                            body: newData
                        );

                        Scaffold.of(ctx).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  LocaleKeys.snackbar.tr(),
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                            ),
                        );
                        Navigator.pop(context);
                        final prefs = await SharedPreferences.getInstance();
                        if(_radioVal2 == 0) {
                          userinfo["name"] = _nameController.text;
                          userinfo["phone"] = _phoneController.text;
                          userinfo["email"] = _emailController.text;
                          userinfo["shax"] = _radioVal2 == 0 ? "individual" : "legal";
                          String userData = jsonEncode(userinfo);
                          await prefs.setString('userData', userData);
                        } else {
                          final companyData = json.encode({
                            "name": controllers[0].text,
                            "city": controllers[1].text,
                            "address": controllers[2].text,
                            "post": controllers[3].text,
                            "bank": controllers[4].text,
                            "bank_account": controllers[5].text,
                            "oked": controllers[6].text,
                            "mfo": controllers[7].text,
                            "inn": controllers[8].text,
                            "okonh": controllers[9].text,
                          });
                          await prefs.setString("companyData", companyData);
                        }

                      } catch(error) {
                        print(error);
                        Dialogs.ErrorDialog(context);
                      }
                    } else {
                      ToastComponent.showDialog(LocaleKeys.Fill_all_fields.tr());
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(16),
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
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
