import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/po_puti/add.dart';
import 'package:travelcars/screens/po_puti/endDrawer.dart';
import 'package:travelcars/screens/po_puti/info.dart';

class PoPutiScreen extends StatefulWidget {
  const PoPutiScreen({Key? key}) : super(key: key);

  @override
  _PoPutiScreenState createState() => _PoPutiScreenState();
}

class _PoPutiScreenState extends State<PoPutiScreen> {
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
          child: End_Drawer()
      ),
      body: SizedBox(
        height: double.infinity,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 7,
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
                      RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1.8,
                              color: Colors.black
                            ),
                            children: [
                              TextSpan(text: "Tashkent - Shahrisabz\n", style: TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(text: "21.09.2021 | 10:00\nChevrolet Lacetti"),
                            ]
                          )
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 30,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black
                              ),
                              children: [
                                TextSpan(text: "Quantity (without cargo): "),
                                TextSpan(text: "4", style: TextStyle(fontWeight: FontWeight.normal)),
                              ]
                            )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.work_outlined,
                          size: 30,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black
                                ),
                                children: [
                                  TextSpan(text: "Quantity (without cargo): "),
                                  TextSpan(text: "4", style: TextStyle(fontWeight: FontWeight.normal)),
                                ]
                            )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Sobirov Ibrohim",
                          style: TextStyle(
                              fontSize: 22
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          size: 30,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "+998 94 659 08 50",
                          style: TextStyle(
                            fontSize: 22
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: MediaQuery.of(context).size.height * .045,
                    width: MediaQuery.of(context).size.width * .8,
                    child:  RaisedButton(
                      onPressed: ()  {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InfoScreen()
                            )
                        );
                      },
                      child: Text(
                        'Details',
                        style: TextStyle(
                            fontSize: 20,
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
}
