import 'package:flutter/material.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:travelcars/screens/search/search_result.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/screens/transfers/transfers_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travelcars',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MainScreen(),
    );
  }
}