import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';

class Cars {
  static Future<List> getcars() async {
    List<dynamic> cars = [];
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getAllCarTypes?locale=${SplashScreen.til}");
    final response = await http.get(url);
    List<dynamic> api_data = json.decode(response.body);
    api_data.forEach((element) {
      cars.add({
        "id": element["id"],
        "name": element["name"],
        "quantity": element["quantity"],
        "image": element["image"],
        "meta_url": element["meta_url"],
        "chosen": false,
      });
    });
    return cars;
  }

  static Future<Map<String, dynamic>> getcategories(List cars) async {
    Map<String, dynamic> categories = {};
    await Future.wait(
      cars.map((element) async {
        Uri url = Uri.parse("${AppConfig.BASE_URL}/carmodels/${element["meta_url"]}/all?lang=${SplashScreen.til}");
        final response = await http.get(url);
        List current_data = json.decode(response.body);
        List<dynamic> item_category = [];
        current_data.forEach((element1) {
          item_category.add(
              {
                "id": element1["id"],
                "name": element1["name"],
                "chosen": false,
              }
          );
        });
        categories.addAll({
          "${element["name"]}": item_category,
        });
      })
    );
    return categories;
  }
}