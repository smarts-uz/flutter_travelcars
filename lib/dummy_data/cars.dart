import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelcars/app_config.dart';

class Cars {
  static Future<List> getcars() async {
    List<dynamic> cars = [];
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getAllCarTypes?locale=ru");
    final response = await http.get(url);
    cars = json.decode(response.body);
    return cars;
  }

  static Future<Map<String, dynamic>> getcategories(List cars) async {
    print(cars);
    Map<String, dynamic> categories = {};
    cars.forEach((element) async {
      Uri url = Uri.parse("${AppConfig.BASE_URL}/carmodels/${element["meta_url"]}/all?lang=ru");
      final response = await http.get(url);
      List current_data = json.decode(response.body);
      List<dynamic> item_category = [];
      current_data.forEach((element1) {
        item_category.add(
          {
            "id": element1["id"],
            "name": element1["name"]
          }
        );
      });
      print(" ${element["text"]} : $item_category");
      categories.addAll({
        "${element["text"]}": item_category,
      });
    });
    return categories;
  }
}