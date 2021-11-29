import 'package:flutter/material.dart';
class RouteInfo extends StatelessWidget {
  Map<String, dynamic> info;

  RouteInfo(@required this.info);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Application #${info['id']}",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25
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
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 12),
              height: info["routes"].length * 90.0,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: info["routes"].length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 8),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              height: 1.4,
                              color: Colors.black,
                              fontSize: 17
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${info["routes"][index]['from']} - ${info["routes"][index]['to']}  ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '( ${info["routes"][index]['date'].substring(0, 10)} )\n'),
                            TextSpan(
                                text: '\t\t\t\tPassengers: ',
                                style: TextStyle(fontWeight: FontWeight.bold,)),
                            TextSpan(text: '${info["routes"][index]['passengers']}\n'),
                            TextSpan(
                                text: '\t\t\t\tWhere to pick up: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: '${info["routes"][index]['address']}'),
                          ],),
                        ),
                  ),
              ),
            ),
            if(info['car_type'] != null) Padding(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: 1.4
                    ),
                    children: [
                      TextSpan(
                          text: 'Type auto: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['carType']}\n'),
                      TextSpan(
                          text: 'Auto: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['car_type']["name"]}\n'),
                      TextSpan(
                          text: 'Status: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['status']}')
                    ]
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Contacts',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, top: 8),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 1.3,
                    ),
                    children: [
                      TextSpan(
                          text: 'E-mail: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_email']}\n'),
                      TextSpan(
                          text: 'Phone number: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_phone']}\n'),
                      TextSpan(
                          text: 'Name: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_name']}')
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
