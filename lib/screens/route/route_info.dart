import 'package:flutter/material.dart';
class RouteInfo extends StatefulWidget {

  Map<String, dynamic> route_item;

  RouteInfo(@required this.route_item);

  @override
  _RouteInfoState createState() => _RouteInfoState();
}

class _RouteInfoState extends State<RouteInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application # 20'),
      ),
      body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16,top: 24),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '${widget.route_item['districtFr1']} - ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                    TextSpan(text: '${widget.route_item['districtTo1']}     ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                    TextSpan(text: '( ${widget.route_item['date1']}  '),
                    TextSpan(text: '${widget.route_item['time2']} )')
                  ],
                ),
              ),
            ),
               Padding(
                 padding: EdgeInsets.only(left: 24,top: 4),
                 child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black
                    ),
                    children: [
                      TextSpan(
                        text: 'Passengers: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                        text: '${widget.route_item['passengers']}'
                      )
                    ]
                  ),
              ),
               ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 4),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'Where to pick up: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['districtFr2']}'
                      )
                    ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,top: 24),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: '${widget.route_item['districtFr1']} - ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                    TextSpan(text: '${widget.route_item['districtTo1']}     ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )),
                    TextSpan(text: '( ${widget.route_item['date1']}  '),
                    TextSpan(text: '${widget.route_item['time2']} )')
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 4),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'Passengers: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['passengers']}'
                      )
                    ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 4),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'Where to pick up: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['districtFr2']}'
                      )
                    ]
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16,top: 24),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'Type auto: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['type auto']}'
                      )
                    ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,top: 8),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'Status: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['status']}'
                      )
                    ]
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 16,top: 24),
              child: Text('Contacts',style: TextStyle(
                fontSize: 17
              ),)
            ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 8),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'E-mail: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['email']}'
                      )
                    ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 4),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'Phone number: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['phone']}'
                      )
                    ]
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 4),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(
                          text: 'Name: ',style: TextStyle(
                          fontWeight: FontWeight.bold
                      )
                      ),
                      TextSpan(
                          text: '${widget.route_item['name']}'
                      )
                    ]
                ),
              ),
            ),
          ],
        ),
    );
  }
}
