import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelcars/app_config.dart';

class Cities {
  static Future<List> getcities() async {
    List<dynamic> cities = [];
    String url = "${AppConfig.BASE_URL}/cities?lang=en";
    final result = await http.get(Uri.parse(url));
    cities = json.decode(result.body)["data"];
    return cities;
  }
}