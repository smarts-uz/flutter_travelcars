import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/feedback/feedback.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import '../../app_config.dart';


class Reviews extends StatefulWidget {
  final int route_price_id;
  Reviews({this.route_price_id = -1});

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  bool isLoading = true;
  double list_height = 0;
  Map<String, dynamic> reviews = {
    'rate': [
      {
        'title': LocaleKeys.punctuality.tr(),
        'name': 'Punctuality',
        "score": 0
      },
      {
        'title': LocaleKeys.car_driving.tr(),
        'name': "driving",
        "score": 0
      },
      {
        'title': LocaleKeys.knowledge_of_traffic.tr(),
        "name": "rules",
        "score": 0
      },
      {
        'title': LocaleKeys.Terrain_orientation.tr(),
        "name": "orientation",
        "score": 0
      },
      {
        'title': LocaleKeys.Knowledge_of_the_language.tr(),
        "name": "language",
        "score": 0
      },
      {
        'title': LocaleKeys.Cleanliness_smell_in_the_cabin.tr(),
        "name": "Cleanliness",
        "score": 0
      },
      {
        'title': LocaleKeys.Amenities_in_the_salon.tr(),
        "name": "salon",
        "score": 0
      },
      {
        'title': LocaleKeys.Level_of_professionalism_of_the_driver.tr(),
        'name': "professionalism",
        "score": 0
      },
      {
        'title':  LocaleKeys.Price_quality_ratio.tr(),
        'name': "Price_quality",
        "score": 0
      },
    ],
    "reviews": []
  };
  List<int> indexes = [];

  @override
  void initState() {
    super.initState();
    if(widget.route_price_id != -2) {
      getComment();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void getComment() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/comments");
    if(widget.route_price_id >= 0) {
      print(widget.route_price_id);
      url = Uri.parse("${AppConfig.BASE_URL}/comments?route_price_id=${widget.route_price_id}");
    }
    final response = await http.get(url);
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
    String average_word = "";
    if(average>=9) {
      average_word = LocaleKeys.excellent.tr();
    } else if(average>=6 && average < 9) {
      average_word = LocaleKeys.good.tr();
    } else if(average>=3 && average < 6) {
      average_word = LocaleKeys.bad.tr();
    } else {
      average_word = LocaleKeys.ver_bad.tr();
    }
    reviews.addAll({
      "average": average.toString(),
      "average_word": average_word,
    });

    for(int i = 0; i<reviews["reviews"].length; i++) {
      indexes.add(i);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          LocaleKeys.reviews.tr(),
          maxLines: 2,
          style: TextStyle(
              fontSize: 23,
              color: Colors.white
          ),
        ),
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : reviews['reviews'].isEmpty ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${LocaleKeys.no_comment_are_found.tr()}\n ",
              style: TextStyle(
                fontSize: 17
              ),
            ),
            Container(
              height: 45,
              width: 200,
              child: ElevatedButton(
                child: Text(
                  LocaleKeys.write_feedback.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedbackScreen(widget.route_price_id),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
            ),
          ],
        ),
      ) : SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.only(left: 16,top: 24, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.customer_reviews.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  Divider(
                    indent: 3,
                    endIndent: 5,
                    thickness: 2,
                    color: Colors.orange,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height*.15,
                          width: MediaQuery.of(context).size.width*.45,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                            "${reviews['average']}",
                              style: TextStyle(
                                fontSize: 65,
                                color: Colors.white
                            ),),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*.08),
                        Center(
                          child: Text(
                            "${reviews['average_word']}\n${reviews['reviews'].length} ${LocaleKeys.review.tr()}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                height: 1.8,
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                          ),
                              ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => FeedbackScreen(widget.route_price_id)
                          )
                      );
                    },
                    child: Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * .8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.orange
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        LocaleKeys.write_feedback.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.orange
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 625,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reviews['rate'].length,
                        itemBuilder: (context,index) {
                          List<String> titles = [
                            LocaleKeys.driver.tr(),
                            LocaleKeys.car.tr(),
                            LocaleKeys.Overall_rating.tr()
                          ];
                          String text_t = index == 0 ? titles[0] : index == 5 ? titles[1] : index == 7 ? titles[2] : " ";
                          double h_cal =  index == 5 || index == 7 || index == 0? 88 : 55;
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
                                   "$text_t: ",
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
                                    Text("${reviews['rate'][index]["score"].round()}"),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                    ),
                  ),
                  Text(
                    '${LocaleKeys.Guest_reviews.tr()}:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                  Divider(
                    endIndent: 250,
                    thickness: 2,
                    color: Colors.orange,
                  ),
                  Column(
                    children: indexes.map((index1) {
                      double sumper = 0;
                      reviews["reviews"][index1]["grade"].forEach((key, value){
                        if(value is String) {
                          sumper+=double.parse(value);
                        } else {
                          sumper += value;
                        }
                      });
                      sumper /= 9;
                      String? sumper_word;
                      if(sumper>=9) {
                        sumper_word = LocaleKeys.excellent.tr();
                      } else if(sumper>=6 && sumper < 9) {
                        sumper_word = LocaleKeys.good.tr();
                      } else if(sumper>=3 && sumper < 6) {
                        sumper_word = LocaleKeys.bad.tr();
                      } else {
                        sumper_word = LocaleKeys.ver_bad.tr();
                      }
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 16.0, bottom: 7.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${reviews["reviews"][index1]["name"]}",
                                        style: TextStyle(
                                            fontSize: 18
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        children: [
                                          reviews['reviews'][index1]['country_code'] == null ? Image.asset(
                                            "assets/images/no_image.png",
                                            fit: BoxFit.contain,
                                          ) : Image.network(
                                            "https://flagcdn.com/w320/${reviews['reviews'][index1]['country_code'].toLowerCase()}.png",
                                            width: 23,
                                            height: 18,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              print(error);
                                              return Image.asset(
                                                "assets/images/no_image.png",
                                                fit: BoxFit.contain,
                                              );
                                            },
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "${reviews['reviews'][index1]['country_name']}",
                                            style: TextStyle(
                                                fontSize: 15
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        children: [
                                          Container(
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
                                          SizedBox(height: 3),
                                          Text(
                                            sumper_word,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15, bottom: 7, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      '${reviews['reviews'][index1]["route_name"]}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, bottom: 7, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      reviews['reviews'][index1]["route_date"] == null ? "" :
                                      '${reviews['reviews'][index1]["route_date"].substring(0,10)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16, bottom: 7, right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${LocaleKeys.recall_time.tr()}: ${reviews["reviews"][index1]["created_at"].substring(0, 16)}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text("${reviews["reviews"][index1]["text"]}",
                                    maxLines: 100,
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
                    }).toList(),
                  ),
                ]
              )
          )
      )
    );
  }
}
