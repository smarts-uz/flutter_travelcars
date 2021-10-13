import 'package:flutter/material.dart';
import 'package:travelcars/screens/profile/account/second_screen.dart';
import 'package:travelcars/screens/profile/account/third_screen.dart';

import 'choice_language.dart';
import 'first_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text("Настройки профиля"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 25),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/Image.png"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 48, top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "John",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.87),
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        letterSpacing: 0.15,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Friderik",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 47,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstSceen()),
                  );
                },
                title: Text("Изменение профиля"),
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
              title: Text("Изменение пароля"),
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
              title: Text("Социальные сети для связи"),
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
              title: Text("Настройка языка и курса"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Divider(),
          SizedBox(
            height: 47,
            child: ListTile(
              onTap: () {},
              title: Text(
                "Выход",
                style: TextStyle(
                  color: Color.fromRGBO(176, 0, 32, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
