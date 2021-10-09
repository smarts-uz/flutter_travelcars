import 'package:flutter/material.dart';

class TripItem extends StatefulWidget {
  final Map<String, dynamic> trip_item;

  TripItem(@required this.trip_item);

  @override
  _TripItemState createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.only(top: 6, left: 13),
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
          ],
        ),
      ),
    );
  }
}
