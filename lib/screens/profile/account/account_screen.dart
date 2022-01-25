import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/profile/account/password_screen.dart';
import 'package:travelcars/screens/profile/account/social_screen.dart';
import 'package:travelcars/screens/search/search.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'user_screen.dart';

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
        title: Text(
          LocaleKeys.profile_settings.tr(),
          maxLines: 2,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: ListTile(
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
                  LocaleKeys.Change_profile.tr(),
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
                LocaleKeys.change_password.tr(),
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
                LocaleKeys.Social_networks_for_communication.tr(),
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
                prefs.remove("userData");
                prefs.remove("companyData");
                SearchScreen.SelectedVal1 = null;
                SearchScreen.SelectedVal2 = null;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                  ModalRoute.withName('/'),
                );
              },
              title: Text(
                LocaleKeys.come_in.tr(),
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