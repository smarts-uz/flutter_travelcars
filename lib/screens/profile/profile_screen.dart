import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/bookings/bookings_screen.dart';
import 'package:travelcars/screens/profile/account/account_screen.dart';
import 'package:travelcars/screens/profile/cashback.dart';
import 'package:travelcars/screens/profile/reviews.dart';
import 'package:travelcars/screens/route/route_screen.dart';
import 'package:travelcars/screens/search/search.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/screens/transfers/transfers_screen.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> routes = [
    {
      "icon": SvgPicture.asset("assets/icons/profile_s.svg"),
      "text": "Account Settings",
      "trailing": true,
      "route": AccountScreen(),
    },
    {
      "icon": Icon(Icons.directions_car, color: Colors.black,),
      "text": "${LocaleKeys.bookings.tr()}",
      "trailing": true,
      "route": BookingsScreen(),
    },
    {
      "icon": SvgPicture.asset('assets/icons/transfer_black.svg'),
      "text": "${LocaleKeys.transfer.tr()}",
      "trailing": true,
      "route": TransfersScreen(),
    },
    {
      "icon": Icon(Icons.map_outlined, color: Colors.black,),
      "text": "${LocaleKeys.routes.tr()}",
      "trailing": true,
      "route": RouteScreen(),
    },
    {
      "icon": SvgPicture.asset('assets/icons/cashback.svg'),
      "text": "${LocaleKeys.cashback.tr()}",
      "trailing": true,
      "route": CashbackScreen(),
    },
    {
      "icon": Icon(Icons.message, color: Colors.black,),
      "text": "${LocaleKeys.reviews.tr()}",
      "trailing": true,
      "route": Reviews(),
    },
    {
      "icon": Icon(Icons.work_outline, color: Colors.black,),
      "text": "About us",
      "trailing": false,
      "route": "https://travelcars.uz/about",
    },
    {
      "icon": SvgPicture.asset('assets/icons/contact.svg'),
      "text": "${LocaleKeys.contact.tr()}",
      "trailing": false,
      "route": "https://travelcars.uz/page/2",
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         LocaleKeys.profile.tr(),
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
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
            icon: Icon(
              Icons.logout,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * .8,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 6),
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: routes.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  if(index == 5 )SizedBox(height: MediaQuery.of(context).size.height * .08),
                  ListTile(
                    leading: Container(
                      height: 20,
                      width: 20,
                      color: Colors.transparent,
                      child: routes[index]["icon"],
                    ),
                    title: Text(
                      routes[index]["text"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17
                      ),
                    ),
                    trailing: routes[index]["trailing"] ? Icon(Icons.arrow_forward_ios_outlined, size: 15,) : Container(
                      width: 10,
                    ),
                    onTap: () async {
                      if(index < 6)  {
                        if(index == 5) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => routes[index]["route"]
                              )
                          );
                          return;
                        }
                        final prefs = await SharedPreferences.getInstance();
                        if(prefs.containsKey('userData')) {
                          final extractedUserData = json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
                          final expiryDate = DateTime.parse(extractedUserData['expiry_at'].substring(0, 10));
                          if(expiryDate.isAfter(DateTime.now())) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => routes[index]["route"]
                                )
                            );
                          } else {
                            Dialogs.LoginDialog(context);
                          }
                        } else {
                          Dialogs.LoginDialog(context);
                        }
                      } else {
                        launch(routes[index]["route"]);
                      }
                    },
                  ),
                  Divider(),
                ],
              ),
            )
        ),
      ),
    );
  }
}
