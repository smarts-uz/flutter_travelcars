import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/transfers/transfers_info.dart';
import 'package:travelcars/screens/transfers/trasfers_add.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

import '../../app_config.dart';


class TransfersScreen extends StatefulWidget {
  const TransfersScreen({Key? key}) : super(key: key);

  @override
  _TransfersScreenState createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen> {
  bool  _isLoading = true;
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
    getTransfers();
  }

  void getTransfers() async {
    String url = "${AppConfig.BASE_URL}/transfers";
    final prefs = await SharedPreferences.getInstance();
    String token = json.decode(prefs.getString('userData')!)["token"];
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      }
    );
    info = json.decode(response.body)["data"];
    setState(() {
      _isLoading = false;
    });
    print(_isLoading);
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
          LocaleKeys.transfers.tr(),
          maxLines: 2,
          style:TextStyle(
              fontSize: 23,
              color: Colors.white
          ),
        ),
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : info.isEmpty ?  Center(
        child: Text(
          LocaleKeys.no_transfer_are_found.tr(),
          style: TextStyle(
              fontSize: 20
          ),
        ),
      ) :  List_T(info, city, cars),
    );
  }
}

class List_T extends StatelessWidget {
  final List info;
  final List city;
  final List cars;
  List_T(@required this.info, @required this.city, @required this.cars);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: info.length,
        itemBuilder: (context, index) {
          if(info[index]["car_type"] != null) {
            cars.forEach((element) {
              if(element["id"] == info[index]["car_type"]["id"]) {
                info[index].addAll({
                  "car": "${element["name"]}"
                });
              }
            });
          } else {
            info[index].addAll({
              "car": "null"
            });
          }
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
                    ),
                  ),
                  trailing: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onPressed: () {},
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
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    LocaleKeys.routes.tr(),
                    style: TextStyle(
                        fontSize: 20
                    ),),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: info[index]["places"].length * 85.0,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: info[index]["places"].length,
                      itemBuilder: (context, index_p) {
                        String location = "";
                        city.forEach((element) {
                          if(element["city_id"] == info[index]["places"][index_p]['city_id']) {
                            location = element["name"];
                            info[index]["places"][index_p].addAll({
                              "city": "${element["name"]}"
                            });
                          }
                        });
                        return Container(
                            padding: EdgeInsets.only(left: 16,bottom:4 ),
                            alignment: Alignment.topLeft,
                            child: RichText(
                              maxLines: 3,
                              text: TextSpan(
                                style: TextStyle(
                                  height: 1.5,
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${info[index]["places"][index_p]['type'] == "meeting" ? LocaleKeys.meeting.tr() : LocaleKeys.Drop_of.tr()}\n',
                                      style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold,)
                                  ),
                                  TextSpan(text: "$location",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                  TextSpan(text:"  (${info[index]["places"][index_p]['date'].substring(0, 10)}, ${info[index]["places"][index_p]['time']})\n",),
                                  TextSpan(text: '${info[index]["places"][index_p]['from']} - ${info[index]["places"][index_p]['to']}',),
                                ],
                              ),
                            )
                        );
                      }
                  ),
                ),
                if(info[index]['created_at'] != null) Container(
                  padding: EdgeInsets.only(left: 16,bottom: 12,top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${LocaleKeys.Created_at.tr()}:',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                ),
                if(info[index]['created_at'] != null) Container(
                  padding: EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${info[index]['created_at'].substring(0, 10)}',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16, top: 20),
                  height: 45,
                  width: MediaQuery.of(context).size.width*.9,
                  child: RaisedButton(
                    color: Colors.white,
                    child:  Text(
                      LocaleKeys.look.tr(),
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransfersInfo(info[index], status)
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

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height*.35,
              width: MediaQuery.of(context).size.width*.65,

              child: Image.asset(
                  'assets/images/map_location.jpg')
          ),
          Container(
              width: MediaQuery.of(context).size.width*.7,
              child: Text(
                '${LocaleKeys.You_can_leave_request.tr()}}',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              )
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height*.045,
            width: MediaQuery.of(context).size.width*.45,
            child: RaisedButton(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.orange,
                  ),
                  SizedBox(
                      width: 10),
                  Text(
                    LocaleKeys.add.tr(),
                    style: TextStyle(
                        color: Colors.orange
                    ),),
                ],
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TransfersAdd()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                      color: Colors.orange
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}

