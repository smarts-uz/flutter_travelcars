import 'package:flutter/material.dart';


class TransfersScreen extends StatefulWidget {
  const TransfersScreen({Key? key}) : super(key: key);

  @override
  _TransfersScreenState createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Column(
          children: [
              Image.asset('assets/images/map_location'),
            Text('Вы можете оставить заявку\n нажимая кнопку ниже'),
            RaisedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                  ),
                  Text('Add'),
                ],
              ),
              onPressed: (){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Colors.orange
                )
              ),
            )
          ],
        )
      ),
    );
  }
}
