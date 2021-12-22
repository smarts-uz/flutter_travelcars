import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/po_puti/add.dart';
import 'package:travelcars/screens/po_puti/info.dart';
import 'package:http/http.dart' as http;

class PoPutiScreen extends StatefulWidget {
  const PoPutiScreen({Key? key}) : super(key: key);

  @override
  _PoPutiScreenState createState() => _PoPutiScreenState();
}

class _PoPutiScreenState extends State<PoPutiScreen> {
  bool isLoading = true;
  late List<dynamic> ways;


  final TextEditingController from = new TextEditingController();
  final TextEditingController to = new TextEditingController();
  DateTime day = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("start");
    getways();
    print("finish");
  }

  void getways() async {
    String url = "${AppConfig.BASE_URL}/getWays";
    final result = await http.get(
      Uri.parse(url)
    );
    setState(() {
      isLoading = false;
      ways = json.decode(result.body)["data"];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Along the way',
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
                "Sorting",
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
                    title: Text(
                      "${DateFormat('dd/MM/yyyy').format(day)}",
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
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
                    ),
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sort',
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
      ) : SizedBox(
        height: double.infinity,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: ways.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: 1.5,
                      color: Colors.grey
                  )
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.3,
                        margin: EdgeInsets.all(10),
                        child: Image.asset("assets/images/lacetti.png", fit: BoxFit.cover,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                height: 1.8,
                                color: Colors.black
                              ),
                              children: [
                                TextSpan(text: "${ways[index]["address1"]} - ${ways[index]["address2"]}\n", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 19)),
                                TextSpan(text: "${ways[index]["date"]} | ${ways[index]["time"].substring(0, 5)} \n${ways[index]["model_car"]} "),
                              ]
                            )
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 28,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black
                              ),
                              children: [
                                TextSpan(text: "Quantity (without cargo): "),
                                TextSpan(text: "${ways[index]["place"]}", style: TextStyle(fontWeight: FontWeight.normal)),
                              ]
                            )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.work_outlined,
                          size: 28,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                                children: [
                                  TextSpan(text: "Quantity (without cargo): "),
                                  TextSpan(text: "${ways[index]["place_bag"]}", style: TextStyle(fontWeight: FontWeight.normal)),
                                ]
                            )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${ways[index]["name"]}",
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          size: 28,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${ways[index]["tel"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
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
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
                        'Details',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.orange
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
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
