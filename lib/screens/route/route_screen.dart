import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/route/route_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  bool _isLoading = true;
  List<dynamic> city = [];
  List<dynamic> cars = [];
  List<dynamic> info = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      cars = HomeScreen.cars_list;
      city = HomeScreen.city_list;
    });
    getRoutes();
  }

  void getRoutes() async {
    final prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString('userData')!)["token"];
    String uri = "${AppConfig.BASE_URL}/routes";
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        "Authorization": "Bearer $token",
      }
    );
    info = json.decode(response.body)["data"];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25
          ),
        ),
        title: Text(
          LocaleKeys.routes.tr(),
          style: TextStyle(
              fontSize: 23,
              color: Colors.white
          ),
        ),
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : info.isEmpty ? Center(
        child: Text(
          LocaleKeys.no_routes_found.tr(),
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ) :  List_R(info, city, cars),
    );
  }
}

class List_R extends StatelessWidget {
  final List info;
  final List city;
  final List car;

  List_R(@required this.info, @required this.city, @required this.car);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: info.length,
        itemBuilder: (context, index) {
          if(info[index]["car_type"] != null) car.forEach((element) {
            if(element["id"] == info[index]["car_type"]['id']) {
              info[index].addAll({
                "carType": element["name"]
              });
            }
          });
          String status = "Unknown";
          Color color = Colors.grey;
          switch(info[index]['status']) {
            case "moderating":
              status = LocaleKeys.route_one_on_consideration.tr();
              color = Colors.amber;
              break;
            case "proceed":
              status = LocaleKeys.pending.tr();
              color =Colors.blue;
              break;
            case "rejected":
              color = Colors.red;
              status = LocaleKeys.rejected.tr();
              break;
            case "accepted":
              status = LocaleKeys.approved.tr();
              color = Colors.green;
              break;
          }
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  leading: Text(
                    "ID ${info[index]['id']}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  trailing: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onPressed: (){},
                    color: color,
                    child: Text(
                      status,
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.routes.tr(),
                    style: TextStyle(
                        fontSize: 23
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25),
                  height: info[index]["routes"].length * 23.0,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: info[index]["routes"].length,
                      itemBuilder: (context, index_p) {
                        city.forEach((element) {
                          if(element["city_id"] == info[index]["routes"][index_p]["city_from"]) {
                            info[index]["routes"][index_p].addAll({
                              "from": "${element["name"]}"
                            });
                          }
                          if(element["city_id"] == info[index]["routes"][index_p]["city_to"]) {
                            info[index]["routes"][index_p].addAll({
                              "to": "${element["name"]}"
                            });
                          }
                        });
                        return RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              height: 1.5,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${info[index]["routes"][index_p]["from"]} - ${info[index]["routes"][index_p]["to"]} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              TextSpan(text: '(${info[index]["routes"][index_p]["date"].substring(0, 10)})',)
                            ],
                          ),
                        );
                      }
                  ),
                ),
                if(info[index]['created_at'] != null) Container(
                  padding: EdgeInsets.only(left: 16, bottom: 8, top: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.Created_at.tr(),
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
                if(info[index]['created_at'] != null) Container(
                  padding: EdgeInsets.only(left: 23 ,bottom:20 ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${info[index]['created_at'].substring(0, 10)}',
                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 45,
                  width: MediaQuery.of(context).size.width*.90,
                  child: RaisedButton(
                    color: Colors.white,
                    child:  Text(
                     LocaleKeys.look.tr(),
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 23
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RouteInfo(info[index], status)
                          )
                      );
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                            color: Colors.grey
                        )
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

