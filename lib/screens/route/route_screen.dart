import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:travelcars/screens/route/route_info.dart';
import 'package:travelcars/screens/transfers/trasfers_add.dart';


class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}
void _startAddNewTransaction(BuildContext ctx)
{
  showModalBottomSheet(
      context: ctx,
      builder: (_)
      {
        return  Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Text('About Transfer',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 24
                ),
              ),
              Divider(),
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing '
                  'elit. Eu venenatis eu id pellentesque.',

                maxLines: 2,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text('\nLorem ipsum dolor sit amet, consectetur adipiscing elit.'
                  ' A, risus, nec accumsan, ultrices vulputate phasellus. '
                  'Sagittis sagittis, quis risus eget vel pulvinar potenti amet. '
                  'Orci nec id maecenas enim rhoncus sodales.'
                  ' Hendrerit cursus purus gravida ultricies. Imperdiet pharetra morbi gravida hac vitae'
                  'ipsum dolor sit amet, consectetur adipiscing elit.'
                  ' A, risus, nec accumsan, ultrices vulputate phasellus. '
                  'Sagittis sagittis, quis risus eget vel pulvinar potenti amet. '
                  'Orci nec id maecenas enim rhoncus sodales.'
                  ' Hendrerit cursus purus gravida ultricies. Imperdiet pharetra morbi gravida hac vitae',
                maxLines: 5,
                style: TextStyle(
                    fontSize: 19
                ),
              )
            ],

          ),
        );
      }
  );
}

class _RouteScreenState extends State<RouteScreen> {
  List<Map<String, dynamic>> info = [
    {
      'id': '20',
      'confirmed': 'Approved',
      'districtFr1': 'Tashkent',
      'districtTo1' :'Samarqand',
      'date1': '01.10.2021',
      'time1' : '02:49',
      'districtFr2': 'Chorsu',
      'districtTo2':'Yunusobot district',
      'time2' : '02:49',
      'name': 'John Fedrik',
      'email': 'example@gmail.com',
      'phone': '+1234567',
      'submit date' : '07.09.2021',
      'passengers':'8',
      'type auto' :'Light Car',
      'status' :'Approved',
    },
    {
      'id': '20',
      'confirmed': 'Approved',
      'districtFr1': 'Tashkent',
      'date1': '01.10.2021',
      'time1' : '02:49',
      'districtFr2': 'Chorsu',
      'districtTo2':'Yunusobot district',
      'time2' : '02:49',
      'name': 'John Fedrik',
      'email': 'example@gmail.com',
      'phone': '+1234567',
      'submit date' : '07.09.2021',
      'passengers':'8',
      'type auto' :'Light Car',
      'status' :'Approved',
    },


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfers',
          style:TextStyle(
              fontSize: 20,
              color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: (){
              _startAddNewTransaction(context);
            },
            icon: Icon(
                Icons.info_outline_rounded
            ),
          )
        ],
      ),
      body: info.isEmpty ?  Empty() :  List_T(info),
    );
  }
}

class Empty extends StatefulWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Container(
              height: MediaQuery.of(context).size.height*.35,
              width: MediaQuery.of(context).size.width*.65,

              child: Image.asset(
                  'assets/images/route_globus.jpg')
          ),
          Container(
              width: MediaQuery.of(context).size.width*.7,
              child: Text(
                'Вы можете оставить заявку\n нажимая кнопку ниже',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              )
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height*.045,
            width: MediaQuery.of(context).size.width*.45,
            child: RaisedButton(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.orange,
                  ),
                  SizedBox(
                      width: 10),
                  Text('Add',
                    style: TextStyle(
                        color: Colors.orange
                    ),),
                ],
              ),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TransfersAdd()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                      color: Colors.orange
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}

class List_T extends StatefulWidget {
  final List info;

  List_T(@required this.info);

  @override
  _List_TState createState() => _List_TState();
}

class _List_TState extends State<List_T> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.info.length,
        itemBuilder: (context, index) => Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: Text("ID ${widget.info[index]['id']}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),),
                trailing: RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  onPressed: (){},
                  color: Colors.lightGreenAccent,
                  child: Text('${widget.info[index]['confirmed']}'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Route',
                  style: TextStyle(
                      fontSize: 20
                  ),),
              ),

              Container(
                padding: EdgeInsets.only(left: 24,bottom:4 ),
                alignment: Alignment.topLeft,
                child: Text('A meeting',style: TextStyle(
                  color: Colors.orange,
                ),),
              ),
              Container(
                  padding: EdgeInsets.only(left: 24,bottom:4 ),
                  alignment: Alignment.topLeft,
                  child:   RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '${widget.info[index]['districtFr1']}       '),
                        TextSpan(text: '${widget.info[index]['date1']}   ',style: TextStyle(
                            fontWeight: FontWeight.bold
                        )),
                        TextSpan(text: ' ${widget.info[index]['time1']} ',style: TextStyle(
                            fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.only(left: 24 ,bottom:6 ),
                  alignment: Alignment.centerLeft,
                  child:
                  RichText(
                    text: TextSpan(

                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '${widget.info[index]['districtFr2']} - '),
                        TextSpan(text: '${widget.info[index]['districtTo2']}   '),
                      ],
                    ),
                  )
              ),

              Container(
                padding: EdgeInsets.only(left: 24,bottom:4 ),
                alignment: Alignment.topLeft,
                child: Text('Conduct',style: TextStyle(
                  color: Colors.orange,
                ),),
              ),
              Container(
                  padding: EdgeInsets.only(left: 24,bottom:4 ),
                  alignment: Alignment.topLeft,
                  child:   RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '${widget.info[index]['districtFr1']}       '),
                        TextSpan(text: '${widget.info[index]['date1']}   ',style: TextStyle(
                            fontWeight: FontWeight.bold
                        )),
                        TextSpan(text: ' ${widget.info[index]['time1']} ',style: TextStyle(
                            fontWeight: FontWeight.bold
                        ))
                      ],
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.only(left: 24 ,bottom:4 ),
                  alignment: Alignment.centerLeft,
                  child:
                  RichText(
                    text: TextSpan(

                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: '${widget.info[index]['districtFr2']} - '),
                        TextSpan(text: '${widget.info[index]['districtTo2']}   '),
                      ],
                    ),
                  )
              ),



              Container(
                padding: EdgeInsets.only(left: 16,bottom: 12,top: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Contact',
                  style: TextStyle(
                      fontSize: 20
                  ),),
              ),
              Container(
                padding: EdgeInsets.only(left: 16,bottom:4 ),
                alignment: Alignment.topLeft,
                child: Text('${widget.info[index]['name']} '),
              ),
              Container(
                padding: EdgeInsets.only(left: 16 ,bottom:4 ),
                alignment: Alignment.centerLeft,
                child: Text('${widget.info[index]['email']} '),
              ),
              Container(
                padding: EdgeInsets.only(left: 16 ,bottom:4 ),
                alignment: Alignment.centerLeft,
                child: Text('${widget.info[index]['phone']} '),
              ),



              Container(
                padding: EdgeInsets.only(left: 16,bottom: 12,top: 16),
                alignment: Alignment.centerLeft,
                child: Text('Day ',
                  style: TextStyle(
                      fontSize: 20
                  ),),
              ),
              Container(
                padding: EdgeInsets.only(left: 16 ,bottom:20 ),
                alignment: Alignment.centerLeft,
                child: Text('${widget.info[index]['submit date']}'),
              ),


              Container(
                margin: EdgeInsets.only(bottom: 16),
                height: MediaQuery.of(context).size.height*.045,
                width: MediaQuery.of(context).size.width*.90,
                child: RaisedButton(
                  color: Colors.white,
                  child:  Text('Look',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20
                    ),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => RouteInfo(widget.info[index])));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.orange
                      )
                  ),
                ),
              ),
            ],
          ),

        ));
  }
}