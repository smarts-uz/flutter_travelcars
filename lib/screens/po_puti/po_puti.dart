import 'package:flutter/material.dart';
import 'package:travelcars/screens/po_puti/add.dart';
import 'package:travelcars/screens/po_puti/endDrawer.dart';

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
    );
  }
}
