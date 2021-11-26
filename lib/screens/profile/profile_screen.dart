import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/bookings/bookings_screen.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:travelcars/screens/profile/account/account_screen.dart';
import 'package:travelcars/screens/profile/cashback.dart';
import 'package:travelcars/screens/profile/reviews.dart';
import 'package:travelcars/screens/route/route_screen.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/screens/transfers/transfers_screen.dart';

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
      "text": "Bookings",
      "trailing": true,
      "route": BookingsScreen(),
    },
    {
      "icon": SvgPicture.asset('assets/icons/transfer_black.svg'),
      "text": "Transfers",
      "trailing": true,
      "route": TransfersScreen(),
    },
    {
      "icon": Icon(Icons.map_outlined, color: Colors.black,),
      "text": "Routes",
      "trailing": true,
      "route": RouteScreen(),
    },
    {
      "icon": SvgPicture.asset('assets/icons/cashback.svg'),
      "text": "Cashback",
      "trailing": true,
      "route": CashbackScreen(),
    },
    {
      "icon": Icon(Icons.work_outline, color: Colors.black,),
      "text": "About us",
      "trailing": false,
      "route": MainScreen(),
    },
    {
      "icon": Icon(Icons.message, color: Colors.black,),
      "text": "Reviews",
      "trailing": true,
      "route": Reviews(),
    },
    {
      "icon": SvgPicture.asset('assets/icons/contact.svg'),
      "text": "Contact",
      "trailing": false,
      "route": MainScreen(),
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.clear();
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
            physics: NeverScrollableScrollPhysics(),
            itemCount: routes.length,
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  if(index == 5 )SizedBox(height: MediaQuery.of(context).size.height * .05),
                  ListTile(
                    leading: routes[index]["icon"],
                    title: Text(
                      routes[index]["text"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 19
                      ),
                    ),
                    trailing: routes[index]["trailing"] ? Icon(Icons.arrow_forward_ios_outlined, size: 15,) : Container(
                      width: 10,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => routes[index]["route"]
                        )
                      );
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
