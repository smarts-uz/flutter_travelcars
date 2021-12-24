import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/dummy_data/cities_list.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:travelcars/screens/transfers/transfers_info.dart';
import 'package:travelcars/screens/transfers/trasfers_add.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    // TODO: implement initState
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
              size: 28
          ),
        ),
        title: Text(
          'Transfers',
          style:TextStyle(
              fontSize: 25,
              color: Colors.white
          ),
        ),
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),)
          : info.isEmpty ?  Empty()
          :  List_T(info, city, cars),
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
                    color: Colors.lightGreenAccent,
                    child: Text('${info[index]['status']}'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Route',
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
                                      text: '${info[index]["places"][index_p]['type']}\n',
                                      style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold,)
                                  ),
                                  TextSpan(text: "$location",),
                                  TextSpan(
                                      text:"  ${info[index]["places"][index_p]['date'].substring(0, 10)} ${info[index]["places"][index_p]['time']}\n",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                  TextSpan(text: '${info[index]["places"][index_p]['from']} - ${info[index]["places"][index_p]['to']}',),
                                ],
                              ),
                            )
                        );
                      }
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,bottom: 10,top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact',
                    style: TextStyle(
                        fontSize: 20
                    ),),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,bottom:4 ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${info[index]['user_name']}\n${info[index]['user_email']}\n${info[index]['user_phone']}',
                    style: TextStyle(
                        height: 1.5,
                        fontSize: 15
                    ),
                  ),
                ),
                if(info[index]['created_at'] != null) Container(
                  padding: EdgeInsets.only(left: 16,bottom: 12,top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Created at:',
                    style: TextStyle(
                        fontSize: 20
                    ),),
                ),
                if(info[index]['created_at'] != null) Container(
                  padding: EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: Text('${info[index]['created_at'].substring(0, 10)}'),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16, top: 20),
                  height: MediaQuery.of(context).size.height*.05,
                  width: MediaQuery.of(context).size.width*.9,
                  child: RaisedButton(
                    color: Colors.white,
                    child:  Text(
                      'Look',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 22
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TransfersInfo(info[index])));
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
                'Вы можете оставить заявку\n нажимая кнопку ниже',
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
                    'Add',
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

