import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirstSceen extends StatefulWidget {
  @override
  _FirstSceenState createState() => _FirstSceenState();
}

class _FirstSceenState extends State<FirstSceen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  List<String> sort = ["Физическое лицо", "Юридическое лицо"];
  int? _radioVal2;
  List<TextEditingController> controllers = [
    for (int i = 0; i < 9; i++)
      TextEditingController()
  ];
  List<String> hints = [
    "Юридическое название",
    "Юридический город",
    "Юридический адрес",
    "Почтовый индекс",
    "Банк",
    "Расчетный счет",
    "ОКЭД",
    "МФО",
    "ИНН",
    "ОКОНХ",
  ];

  Map<String, dynamic> userinfo = {};
  Map<String, dynamic> companyinfo = {};

  @override
  void initState() {
    // TODO: implement initState
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
    });
  }
  void getcompanydata() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("companyData")) {
      int i = 0;
      setState(() {
        companyinfo = json.decode(prefs.getString('companyData')!) as Map<String, dynamic>;
        print(companyinfo);
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
        centerTitle: true,
        title: Text(
          "Изменение профиля",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23
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
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .81,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/Image.png"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, right: 16, left: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.5),
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Mail",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 33),
                          TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "ФИО",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 33),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Телефон",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [0, 1]
                                  .map((int index) => Container(
                                        alignment: Alignment.centerLeft,
                                        height: 40,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Radio<int>(
                                              value: index,
                                              groupValue: userinfo["shaxs"] == "individual" ? 0 : 1,
                                              onChanged: (int? value) {
                                                if (value != null) {
                                                  /*setState(() => this
                                                      ._radioVal2 = value);
                                                  print(value);*/
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
                                      ))
                                  .toList(),
                            ),
                          ),
                          if (companyinfo.isNotEmpty) Column(
                            children: [0, 1, 2, 3,4,5,6,7,8,].map((e) => Container(
                              width: double.infinity,
                              height:  65,
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                                    fontSize: 20
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
            GestureDetector(
              onTap: () {},
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
                    "Сохранить",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
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
}
