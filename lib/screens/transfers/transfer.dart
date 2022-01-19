import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/screens/transfers/trasfers_add.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

import '../../dialogs.dart';

class Transfer extends StatelessWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         LocaleKeys.transfer.tr(),
          style:TextStyle(
              fontSize: 25,
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
              Icons.info_outline_rounded,
              size: 30,
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
                child: Image.asset('assets/images/map_location.jpg')
            ),
            Container(
                width: MediaQuery.of(context).size.width*.7,
                child: Text(
                  LocaleKeys.You_can_leave_request.tr(),
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 18,
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
                        width: 10
                    ),
                    Text(
                     LocaleKeys.add.tr(),
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 17
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransfersAdd()
                      )
                  );
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

void _startAddNewTransaction(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return  Container(
          height: 130,
          margin: EdgeInsets.all(16),
          child: Text(
            LocaleKeys.about_transfer.tr(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),
          ),
        );
      }
  );
}
