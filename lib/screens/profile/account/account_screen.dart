import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/profile/account/second_screen.dart';
import 'package:travelcars/screens/profile/account/third_screen.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';

import 'choice_language.dart';
import 'first_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String name = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final userinfo = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      email = userinfo["email"] != null ? userinfo["email"] : "";
      name = userinfo["name"] != null ? userinfo["name"] : "";

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text(
          "Настройки профиля",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: ListTile(
              leading: Container(
                height: 100,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Image.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.centerLeft,
              ),
              title: Text(
                name,
                maxLines: 2,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.87),
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                  letterSpacing: 0.15,
                ),
              ),
              subtitle:  Text(
                email,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              height: 47,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstSceen()),
                  );
                },
                title: Text(
                  "Изменение профиля",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 47,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(),
                  ),
                );
              },
              title: Text(
                "Изменение пароля",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Divider(),
          SizedBox(
            height: 47,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdScreen(),
                  ),
                );
              },
              title: Text(
                "Социальные сети для связи",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Divider(),
          SizedBox(
            height: 47,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChoicePage()),
                );
              },
              title: Text(
                "Настройка языка и курса",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Divider(),
          SizedBox(
            height: 47,
            child: ListTile(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  ModalRoute.withName('/'),
                );
              },
              title: Text(
                "Выход",
                style: TextStyle(
                  color: Color.fromRGBO(176, 0, 32, 1),
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}