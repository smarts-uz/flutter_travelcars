import 'package:flutter/material.dart';

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
          widget.trip_item["text"],
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print("pressed");},
              icon: Icon(
                Icons.list_alt_outlined,
                size: 30,
                color: Colors.white,
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
               height: MediaQuery.of(context).size.height * .35,
               width: double.infinity,
               padding: EdgeInsets.only(top: 20, left: 13, right: 13, bottom: 5),
               child: Image.asset(widget.trip_item["image"], fit: BoxFit.cover,)
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 3, left: 13),
              child: Text(
                widget.trip_item["text"],
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
                    widget.trip_item["location"],
                    style: TextStyle(
                      fontSize: 13
                    )
                  ),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(left: 13, top: 9, right: 10),
              child: Text(
                widget.trip_item["description"],
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 7, left: 10, right: 10),
              margin: EdgeInsets.only(top: 15, left: 13, right: 13),
              height: 60,
              color: Color.fromRGBO(255, 250, 241, 1),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Duration of the trip: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '${widget.trip_item["day"]} day'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.0,
                          color: Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Time: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: '${widget.trip_item["time"]} hours'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 13, top: 13, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trip program: \n",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                  Text(
                    "${widget.trip_item["details"]}",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.black
                    ),
                  ),
                ],
              )
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
                    "Search",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    print("Name: ${controllers[0].text}");
                    print("E-mail: ${controllers[1].text}");
                    print("Phone: ${controllers[2].text}");
                    print("Comment: ${controllers[3].text}");
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}