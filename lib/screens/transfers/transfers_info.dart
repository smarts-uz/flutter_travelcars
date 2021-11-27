import 'package:flutter/material.dart';
class TransfersInfo extends StatefulWidget {

  Map<String, dynamic> info;

  TransfersInfo(@required this.info);

  @override
  _TransfersInfoState createState() => _TransfersInfoState();
}

class _TransfersInfoState extends State<TransfersInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Application #${widget.info['id']}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 12),
              height: widget.info["places"].length * 157.0,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.info["places"].length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 8),
                        child: Text(
                          '${widget.info["places"][index]["type"]}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange
                          ),),

                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24, top: 6),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontSize: 15
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${widget.info["places"][index]['city']} ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(text: '( ${widget.info["places"][index]['date'].substring(0, 10)} '),
                              TextSpan(text: '${widget.info["places"][index]['time']})\n'),
                              TextSpan(
                                  text: 'Passengers: ',
                                  style: TextStyle(fontWeight: FontWeight.bold,)
                              ),
                              TextSpan(text: '${widget.info["places"][index]['passengers']}\n'),
                              TextSpan(
                                  text: 'Where to pick up: ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(text: '${widget.info["places"][index]['from']}\n'),
                              TextSpan(
                                  text: 'Where: ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(
                                  text: '${widget.info["places"][index]['to']}\n'
                              ),
                              TextSpan(
                                  text: 'Note: ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(
                                  text: '${widget.info["places"][index]['additional']}'
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16,top: 16),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                    ),
                    children: [
                      TextSpan(
                          text: 'Type auto: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${widget.info['car']}\n'),
                      TextSpan(
                          text: 'Status: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${widget.info['status']}')
                    ]
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16,top: 24),
                child: Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 8),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                    children: [
                      TextSpan(
                          text: 'E-mail: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${widget.info['user_email']}\n'),
                      TextSpan(
                          text: 'Phone number: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${widget.info['user_phone']}\n'),
                      TextSpan(
                          text: 'Name: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${widget.info['user_name']}')
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
