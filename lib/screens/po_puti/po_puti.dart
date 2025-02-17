import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int? user_id;
  String? token;
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
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("userData") != null) {
      user_id = jsonDecode(prefs.getString("userData")!)["user_id"];
      token = jsonDecode(prefs.getString("userData")!)["token"];
    }
    ways = json.decode(result.body)["data"];
    main_ways = json.decode(result.body)["data"];
    for(int i = 0; i < main_ways.length; i++) {
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
        title: Text(
          LocaleKeys.Along_the_way.tr(),
          maxLines: 2,
          style: TextStyle(
            fontSize: 20,
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
            size: 23,
          ),
        ),
        actions: [
          /* InkWell(
            onTap: () {
              _startAddNewTransaction(context);
            },
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 23,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddScreen()
                  )
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 23,
            ),
          ),
          Builder(
              builder: (ctx) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(ctx).openEndDrawer();
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 23,
                  ),
                );
              }
          ),*/
          IconButton(
            color: Colors.white,
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: Icon(
              Icons.info_outline_rounded,
              color: Colors.white,
              size: 23,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 23,
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
                      size: 23,
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
                maxLines: 2,
                style: TextStyle(
                  fontSize: 22,
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
                TFF(LocaleKeys.From.tr(), from),
                TFF(LocaleKeys.To.tr(), to),
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
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2050),
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
                      day == null ? " " : "${DateFormat('dd.MM.yyyy').format(day!)}",
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    trailing: Icon(Icons.calendar_today),
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  height: MediaQuery.of(context).size.height * .045,
                  width: MediaQuery.of(context).size.width * .8,
                  child:  ElevatedButton(
                    onPressed: ()  {
                      List<dynamic> new_ways = [];
                      main_ways.forEach((element) {
                        if(element["address1"] == from.text || from.text.isEmpty) {
                          if(element["address2"] == to.text || to.text.isEmpty) {
                            if(day == null) {
                              new_ways.add(element);
                            } else if(element["date"] == DateFormat('dd.MM.yyyy').format(day!))
                              {
                                new_ways.add(element);
                              }
                          }
                        }
                      });
                      setState(() {
                        ways = new_ways;
                        indexes = [];
                        for(int i = 0; i < ways.length; i++) {
                          indexes.add(i);
                        }
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
                    // color: Colors.blue,
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
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: indexes.map((index) {
              return Container(
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
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 17,
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
                    ways[index]["user_id"] != user_id || user_id == null ? GestureDetector(
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
                        height: 40,
                        width: MediaQuery.of(context).size.width * .9,
                        child:  Text(
                          LocaleKeys.details.tr(),
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.orange
                          ),
                        ),
                      ),
                    ) : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 23,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AddScreen(way_item: ways[index],)
                                  )
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 23,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          GestureDetector(
                            onTap: () async {
                              Uri url = Uri.parse("${AppConfig.BASE_URL}/onway/delete");
                              final response = await http.delete(
                                  url,
                                  headers: {
                                    "Authorization": "Bearer $token"
                                  },
                                  body: {
                                    "id": "${ways[index]["id"]}"
                                  }
                              );
                              setState(() {
                                isLoading = true;
                              });
                              indexes = [];
                              getways();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 23,
                              ),
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
        ),
      ),
    );
  }
  Widget TFF (String? hintText, TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 18
        ),
        expands: false,
        maxLines: 1,
      ),
    );
  }
}

void _startAddNewTransaction(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return  Container(
          height: 185,
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
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
        );
      }
  );
}
