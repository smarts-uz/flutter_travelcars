import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class End_Drawer extends StatefulWidget {
  const End_Drawer({Key? key}) : super(key: key);

  @override
  _End_DrawerState createState() => _End_DrawerState();
}

class _End_DrawerState extends State<End_Drawer> {
  final TextEditingController from = new TextEditingController();
  final TextEditingController to = new TextEditingController();
  DateTime day = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              size: 30,
              color: Colors.white,
            )
        ),
        title: Text(
          "Sorting",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          TFF("From", from),
          TFF("To", to),
          Container(
            width: double.infinity,
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)
            ),
            child: ListTile(
              title: Text(
                "${DateFormat('dd/MM/yyyy').format(day)}",
              ),
              trailing: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  ).then((pickedDate) {
                    if(pickedDate==null)
                    {
                      return;
                    }
                    setState(() {
                      day = pickedDate;
                    });
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
            ),
            height: MediaQuery.of(context).size.height * .045,
            width: MediaQuery.of(context).size.width * .8,
            child:  RaisedButton(
              onPressed: ()  {
                Navigator.pop(context);
              },
              child: Text(
                'Sort',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
  Widget TFF (String? hintText, TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 55,
      padding: EdgeInsets.only(left: 6),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: hintText,
          hintMaxLines: 3,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0,
            ),
          ),
        ),
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 20
        ),
        expands: false,
        maxLines: 7,
      ),
    );
  }
}
