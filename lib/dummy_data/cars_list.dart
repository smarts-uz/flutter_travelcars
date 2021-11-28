import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelcars/app_config.dart';

class Cars {
  static Future<List> getcars() async {
    List<dynamic> cars = [];
    String url = "${AppConfig.BASE_URL}/getAllCarTypes?lang=ru";
    final response = await http.get(Uri.parse(url));
    cars = json.decode(response.body)["car_types"];
    return cars;
  }
}