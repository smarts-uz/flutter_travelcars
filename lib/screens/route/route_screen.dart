import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/main_screen.dart';
import 'package:travelcars/screens/route/route_add.dart';


class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route',
          style:TextStyle(
              fontSize: 20,
              color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: (){},
            icon: Icon(
                Icons.info_outline_rounded
            ),
          )
        ],
      ),
      body: Container(
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
                  'Вы можете оставить заявку \n нажимая кнопку ниже',
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
                  MaterialPageRoute(builder: (context) => RouteAdd()));
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
      ),
    );
  }
}
