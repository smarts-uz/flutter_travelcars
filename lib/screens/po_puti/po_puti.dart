import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/po_puti/add.dart';
import 'package:travelcars/screens/po_puti/info.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';

class PoPutiScreen extends StatefulWidget {
  const PoPutiScreen({Key? key}) : super(key: key);

  @override
  _PoPutiScreenState createState() => _PoPutiScreenState();
}

class _PoPutiScreenState extends State<PoPutiScreen> {
  bool isLoading = true;
  late List<dynamic> ways;
  late List<dynamic> main_ways;
  List<int> indexes = [];


  final TextEditingController from = new TextEditingController();
  final TextEditingController to = new TextEditingController();
  DateTime? day;

  @override
  void initState() {
    super.initState();
    getways();
  }

  void getways() async {
    String url = "${AppConfig.BASE_URL}/getWays";
    final result = await http.get(
      Uri.parse(url)
    );
    setState(() {
      isLoading = false;
      ways = json.decode(result.body)["data"];
      for(int i = 0; i < ways.length; i++) {
        indexes.add(i);
      }
      main_ways = json.decode(result.body)["data"];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.Along_the_way.tr(),
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddScreen()
                  )
              );
            },
          ),
         Builder(
             builder: (ctx) {
               return IconButton(
                   onPressed: () {
                     Scaffold.of(ctx).openEndDrawer();
                   },
                   icon: Icon(
                     Icons.search,
                     color: Colors.white,
                   ),
               );
             }
         )
        ],
      ),
      endDrawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.white,
                  )
              ),
              title: Text(
                LocaleKeys.sorting.tr(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                TFF("From", from),
                TFF("To", to),
                Container(
                  width: double.infinity,
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: ListTile(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2030),
                      ).then((pickedDate) {
                        if(pickedDate==null)
                        {
                          return;
                        }
                        setState(() {
                          day = pickedDate;
                        });
                      });
                    },
                    title: Text(
                      day == null ? " " : "${DateFormat('yyyy-MM-dd').format(day!)}",
                    ),
                    trailing: Icon(Icons.calendar_today),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  height: MediaQuery.of(context).size.height * .045,
                  width: MediaQuery.of(context).size.width * .8,
                  child:  RaisedButton(
                    onPressed: ()  {
                      List<dynamic> new_ways = [];
                      main_ways.forEach((element) {
                        if(element["address1"] == from.text || from.text.isEmpty) {
                          if(element["address2"] == to.text || to.text.isEmpty) {
                            if(day == null) {
                              new_ways.add(element);
                            } else if(element["date"] == DateFormat('yyyy-MM-dd').format(day!))
                              {
                                new_ways.add(element);
                              }
                          }
                        }
                      });
                      setState(() {
                        ways = new_ways;
                      });
                      day = null;
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Text(
                      LocaleKeys.Sort.tr(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
      ),
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : ways.isEmpty ? Center(
        child: Text(
          LocaleKeys.Nothing_found.tr(),
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ) : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(text: "${LocaleKeys.poputi1.tr()}\n", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: LocaleKeys.poputi2.tr(), style: TextStyle(fontStyle: FontStyle.italic)),
                  ]
                ),
              ),
            ),
            Column(
              children: indexes.map((index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1.5,
                        color: Colors.grey
                    )
                ),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 20),
                      child: Expanded(
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontSize: 19,
                                    height: 1.7,
                                    color: Colors.black
                                ),
                                children: [
                                  TextSpan(text: "${LocaleKeys.From.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "${ways[index]["address1"]}\n"),
                                  TextSpan(text: "${LocaleKeys.To.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "${ways[index]["address2"]}\n"),
                                  TextSpan(text: "${LocaleKeys.Date.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "${ways[index]["date"]}\n"),
                                  TextSpan(text: "${LocaleKeys.Time.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "${ways[index]["time"].substring(0, 5)}\n"),
                                  TextSpan(text: "${LocaleKeys.Car_type.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: "${ways[index]["model_car"]}"),
                                ]
                            )
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InfoScreen(ways[index])
                            )
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.grey,
                                width: 1.5
                            )
                        ),
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width * .9,
                        child:  Text(
                          LocaleKeys.details.tr(),
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.orange
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
  Widget TFF (String? hintText, TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: EdgeInsets.only(left: 6),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: hintText,
          hintMaxLines: 3,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
        ),
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 20
        ),
        expands: false,
        maxLines: 7,
      ),
    );
  }
}
