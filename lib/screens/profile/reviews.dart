import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/feedback/feedback.dart';
import '../../app_config.dart';
import '../../dialogs.dart';
class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isLoading = true;
  double list_height = 0;
  Map<String, dynamic> reviews = {
    'rate': [
      {
        'title': 'Punctuality',
        'name': 'Punctuality',
        "score": 8.0
      },
      {
        'title': 'Car driving',
        'name': "driving",
        "score": 3.0
      },
      {
        'title': 'Knowledge',
        "name": "rules",
        "score": 7.0
      },
      {
        'title': 'Orientation',
        "name": "orientation",
        "score": 6.0
      },
      {
        'title': 'Language',
        "name": "language",
        "score": 9.0
      },
      {
        'title': 'Chistota',
        "name": "Cleanliness",
        "score": 9.0
      },
      {
        'title': 'Qulalylik',
        "name": "salon",
        "score": 5.0
      },
      {
        'title': 'Profiessinal',
        'name': "professionalism",
        "score": 5.0
      },
      {
        'title': 'Sena kachestva',
        'name': "Price_quality",
        "score": 10.0
      },
    ],
    "reviews": []
  };

  @override
  void initState() {
    super.initState();
    getComment();
  }

  void getComment() async {
    String url = "${AppConfig.BASE_URL}/comments";
    final response = await http.get(
        Uri.parse(url)
    );
    setState(() {
      Map<String, dynamic> info = json.decode(response.body)["data"];
      info['all_grade'].forEach((key, value) {
        reviews["rate"].forEach((element) {
          if(key == element["name"]) {
            element["score"] = value;
          }
        }
        );
      }
      );
      reviews['reviews'] = info["comments"];
      double summa = 0;
      reviews["rate"].forEach((element) {
       summa+=element["score"];
      });
      summa /= 9;
      int average = summa.round();

      reviews
          .addAll({
        "average": average.toString(),
      });

      isLoading = false;

    }
    );

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
            size: 28,
          ),
        ),
        title: Text('Reviews',
        style: TextStyle(
          fontSize: 25,
          color: Colors.white
        ),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.only(left: 16,top: 24, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                  Divider(
                    endIndent: 220,
                    thickness: 2,
                    color: Colors.orange,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 11,right: 30),
                          height: MediaQuery.of(context).size.height*.15,
                          width: MediaQuery.of(context).size.width*.45,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                            "  ${reviews['average']}",
                              style: TextStyle(
                                fontSize: 65,
                                color: Colors.white
                            ),),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 27,left: 14),
                          height: MediaQuery.of(context).size.height*.1,
                          width: MediaQuery.of(context).size.width*.35,
                          child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                  "${reviews['reviews'].length} comments",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*.055,
                                width: MediaQuery.of(context).size.width*.45,
                                child: RaisedButton(
                                  color: Colors.white,
                                  child:Text(
                                    'Write a feedback',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.orange
                                  ),
                                  ),
                                  onPressed: () async {
                                    final prefs = await SharedPreferences.getInstance();
                                    if(prefs.containsKey('userData')) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => FeedbackScreen()
                                          )
                                      );
                                    } else {
                                      Dialogs.LoginDialog(context);
                                    }

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
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * .95,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reviews['rate'].length,
                        itemBuilder: (context,index) {
                          List<String> titles = [
                            "Driver",
                            "Car",
                            "Overall rating"
                          ];
                          String text_t = index == 0 ? titles[0] : index == 5 ? titles[1] : index == 7 ? titles[2] : " ";
                          double h_cal =  index == 5 || index == 7 || index == 0? 110 : 55;
                          double rate = (reviews['rate'][index]["score"])/10;

                          return Container(
                            alignment: Alignment.bottomCenter,
                            height: h_cal,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text_t != " " ? Container(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                   text_t,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ) : Text(''),
                                Text(
                                  "${reviews['rate'][index]["title"]}",
                                  style: TextStyle(
                                    fontSize: 17
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 10,
                                      width: MediaQuery.of(context).size.width*.85,
                                      child: FractionallySizedBox(
                                        widthFactor: rate,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text("${reviews['rate'][index]["score"].toInt()}"),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        ),

                  ),
                  Text(
                    'Guest reviews:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                  Divider(
                    endIndent: 250,
                    thickness: 2,
                    color: Colors.orange,
                  ),
                  Container(
                   height: reviews["reviews"].length * 330.0,
                   child: ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     itemCount:reviews["reviews"].length,
                     itemBuilder: (context,index1) {
                       double sumper = 0;
                       reviews["reviews"][index1]["grade"].forEach((key, value){
                         if(value is String) {
                           sumper+=double.parse(value);
                         } else {
                           sumper += value;
                         }
                       });
                       sumper /= 9;
                       return Card(
                         margin: EdgeInsets.symmetric(vertical: 8),
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                         elevation: 4,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             ListTile(
                               leading: CircleAvatar(
                                 radius: 20,
                                 backgroundImage: AssetImage("assets/Image.png"),
                               ),
                               title: Text('${reviews["reviews"][index1]["name"]},'),
                               subtitle: Text('${reviews['reviews'][index1]['country_name']}'),
                               trailing: Container(
                                 height: 27,
                                 width: 27,
                                 decoration: BoxDecoration(
                                   color: Colors.orange,
                                   borderRadius: BorderRadius.circular(4.0),
                                 ),
                                 child: Center(
                                   child: Text(
                                     sumper.round().toInt().toString(),
                                     style: TextStyle(
                                       color: Colors.white
                                     ),
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 8, top: 0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     width : MediaQuery.of(context).size.width*.5,
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         Icon(
                                           Icons.location_on,
                                           color: Colors.orange,
                                         ),
                                         Expanded(
                                           child: Text(
                                             '${reviews['reviews'][index1]["route_name"]}',
                                             overflow: TextOverflow.ellipsis,
                                             //softWrap: false,
                                             style: TextStyle(
                                                 fontWeight: FontWeight.bold,
                                                 fontStyle: FontStyle.italic
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                   FlatButton.icon(
                                       onPressed: () {},
                                       icon:  Icon(
                                         Icons.calendar_today_outlined,
                                         color: Colors.orange,
                                       ),
                                       label: Text(
                                         '${reviews['reviews'][index1]["created_at"].substring(0,10)}',
                                         style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontStyle: FontStyle.italic
                                         ),
                                       )
                                   ),
                                 ],
                               ),
                             ),
                             Container(
                               padding: EdgeInsets.only(left: 16, bottom: 10, right: 16),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     "Order time : ${reviews["reviews"][index1]["route_date"].substring(0,10)}",
                                     textAlign: TextAlign.start,
                                     style: TextStyle(
                                         fontSize: 15,
                                         decoration: TextDecoration.underline,
                                         fontStyle: FontStyle.italic
                                     ),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Text("${reviews["reviews"][index1]["text"]}",
                                     maxLines: 12,
                                     textAlign: TextAlign.justify,
                                     style: TextStyle(
                                       fontSize: 15,
                                         fontStyle: FontStyle.italic
                                     ),
                                   )
                                 ],
                               ),
                             ),
                           ],
                         ),

                       );
                     },
                   )
                  ),
                ]
              )
          )
      )
    );
  }
}
