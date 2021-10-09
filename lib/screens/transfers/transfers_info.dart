import 'package:flutter/material.dart';
class TransfersInfo extends StatefulWidget {

  Map<String, dynamic> transfer_item;

  TransfersInfo(@required this.transfer_item);

  @override
  _TransfersInfoState createState() => _TransfersInfoState();
}

class _TransfersInfoState extends State<TransfersInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application # 20'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 16,top: 24),
            child: Text('A meeting',
              style: TextStyle(
                fontSize: 15,
                color: Colors.orange
              ),),

          ),
          Padding(
            padding: EdgeInsets.only(left: 24,top: 8),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: '${widget.transfer_item['districtFr1']} ',style: TextStyle(
                      fontWeight: FontWeight.bold
                  )),
                  TextSpan(text: '( ${widget.transfer_item['date1']}  '),
                  TextSpan(text: '${widget.transfer_item['time2']} )')
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
                        text: '${widget.transfer_item['passengers']}'
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
                        text: '${widget.transfer_item['districtFr2']}'
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
                        text: 'Where: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )
                    ),
                    TextSpan(
                        text: '${widget.transfer_item['districtTo2']}'
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
                        text: 'Note: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )
                    ),
                    TextSpan(
                        text: '${widget.transfer_item['note']}'
                    )
                  ]
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16,top: 24),
            child: Text('The wire',
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.orange
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24,top: 8),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: '${widget.transfer_item['districtFr1']} ',style: TextStyle(
                      fontWeight: FontWeight.bold
                  )),
                  TextSpan(text: '( ${widget.transfer_item['date1']}  '),
                  TextSpan(text: '${widget.transfer_item['time2']} )')
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
                        text: '${widget.transfer_item['passengers']}'
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
                        text: '${widget.transfer_item['districtFr2']}'
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
                        text: 'Where: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )
                    ),
                    TextSpan(
                        text: '${widget.transfer_item['districtTo2']}'
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
                        text: 'Note: ',style: TextStyle(
                        fontWeight: FontWeight.bold
                    )
                    ),
                    TextSpan(
                        text: '${widget.transfer_item['note']}'
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
                        text: '${widget.transfer_item['type auto']}'
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
                        text: '${widget.transfer_item['status']}'
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
                        text: '${widget.transfer_item['email']}'
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
                        text: '${widget.transfer_item['phone']}'
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
                        text: '${widget.transfer_item['name']}'
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
