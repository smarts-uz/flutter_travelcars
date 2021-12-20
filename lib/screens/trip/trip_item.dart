import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/app_config.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:travelcars/dialogs.dart';

class TripItem extends StatefulWidget {
  final Map<String, dynamic> trip_item;

  TripItem(@required this.trip_item);

  @override
  _TripItemState createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {

  List<TextEditingController> controllers = [
    for (int i = 0; i < 4; i++)
      TextEditingController()
  ];
  List<String> hints = ["Name", "E-mail", "Phone", "Write a comment"];




  @override
  Widget build(BuildContext context) {
    double size_h = MediaQuery.of(context).size.height * .25;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.trip_item["name"],
          style: TextStyle(
            fontSize: 25,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
               height: MediaQuery.of(context).size.height * .3,
               width: double.infinity,
               padding: EdgeInsets.only(top: 20, left: 13, right: 13, bottom: 5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "http://travelcars.teampro.uz/uploads/tours/${widget.trip_item["image"]}",
                    ),
                    fit: BoxFit.cover,
                  ),
                  //borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 13, left: 13),
              child: Text(
                widget.trip_item["name"],
                style: TextStyle(
                  fontSize: 27,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 4, left: 9),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.orange,
                    size: 22,
                  ),
                  Text(
                    widget.trip_item["content"],
                    style: TextStyle(
                      fontSize: 13
                    )
                  ),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 5, top: 9, right: 10),
              child: Html(
                data: widget.trip_item["region"],
                style: {
                  "table": Style(
                    backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                  ),
                  "tr": Style(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  "th": Style(
                    padding: EdgeInsets.all(6),
                    backgroundColor: Colors.grey,
                  ),
                  "td": Style(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.topLeft,
                  ),
                  'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                },
                customRender: {
                  "table": (context, child) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:
                      (context.tree as TableLayoutElement).toWidget(context),
                    );
                  },
                },
              ),
            ),
            Container(
              height: size_h,
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, left: 17, right: 17, bottom: 5),
              child: Stack(
                children: [
                  Container(
                    color: Color.fromRGBO(239, 127, 26, 1),
                  ),
                  Positioned(
                    top: size_h * .05,
                    left: 15,
                    child: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 85,
                    ),
                  ),
                  Positioned(
                      left: 15,
                      bottom: size_h * .2,
                      child: Text(
                        "Book now",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white
                        ),
                      )
                  ),
                  Positioned(
                      left: 15,
                      bottom: size_h * .05,
                      child: Text(
                        "We will be glad to receive your order!",
                        style: TextStyle(
                          fontSize: 18.0,
                            color: Colors.white
                        ),
                      )
                  )
                ],
              ),
            ),
            Column(
              children: [0, 1, 2, 3].map((e) => Container(
                width: double.infinity,
                height: e == 3 ? 150 : 50,
                padding: EdgeInsets.only(left: 15),
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: TextFormField(
                  key: ValueKey(hints[e]),
                  keyboardType: e == 2 ? TextInputType.number : TextInputType.text,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    hintText: hints[e],
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
                  controller: controllers[e],
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: 20
                  ),
                  expands: false,
                  maxLines: e == 3 ? 3 : 1,
                ),
              ),).toList(),
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              margin: EdgeInsets.only(top: 15),
              child: RaisedButton(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: Color.fromRGBO(0, 116, 201, 1),
                  padding: EdgeInsets.all(8),
                  textColor: Colors.white,
                  child: Text(
                    "Send",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    bool isValid = true;
                    Map<String, dynamic> info = {
                      "name": "${controllers[0].text}",
                      "email": "${controllers[1].text}",
                      "phone": "${controllers[2].text}",
                      "comment": "${controllers[3].text}",
                      "tour_id": "${widget.trip_item["id"]}"
                    };
                    info.forEach((key, value) {
                      if(value == null || value == "") {
                        print("Write $key");
                        isValid = false;
                      }
                    });
                    if(isValid) {
                      String url = "${AppConfig.BASE_URL}/tours/creates";
                      try {
                        final result = await http.post(
                            Uri.parse(url),
                            body: info
                        );
                        if(json.decode(result.body)["message"] == "Not found.") {
                          Dialogs.ErrorDialog(context);
                        } else {
                          Dialogs.ZayavkaDialog(context);
                        }
                      } catch (error) {
                        print(error);
                        Dialogs.ErrorDialog(context);
                      }
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}