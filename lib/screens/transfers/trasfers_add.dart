import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
class TransfersAdd extends StatefulWidget {
  const TransfersAdd({Key? key}) : super(key: key);

  @override
  _TransfersAddState createState() => _TransfersAddState();
}

class _TransfersAddState extends State<TransfersAdd> {
  List<String> directions = [
    'Meeting',
    'The wire'
  ];
  static const city = <String>[
    "Tashkent",
    "Buxoro",
    "Xiva",
    "Samarkand"
  ];
  final List<DropdownMenuItem<String>> cities = city.map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
    ),
  ).toList();
  int i = 1;

  List<Map<String, dynamic>> data = [
    {
      "direction": 0,
      "city": city[0],
      "day": DateTime.now(),
      "time": TimeOfDay.now(),
      "controllers4": [
        for (int i = 0; i < 4; i++)
          TextEditingController()
      ],
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TravelCars'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/globus.svg',
              color: Colors.white,
            ),
            onPressed: () { },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .75,
            child: ListView.builder(
                itemCount: i,
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                  margin: EdgeInsets.fromLTRB(16, 24, 16, 24),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    margin:EdgeInsets.all(17),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        child: Text(
                          "${index + 1}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [0, 1].map((int indexr) => Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*.4,
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Radio<int>(
                                  value: indexr,
                                  groupValue: data[index]["direction"],
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      setState(() => data[index]["direction"] = value);
                                      print(value);
                                    }
                                    },
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  directions[indexr],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        ).toList(),
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        padding: EdgeInsets.only(left: 6, right: 6),
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Container(
                            child:DropdownButton<String>(
                              hint: Text(
                                  "City",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black
                                  )
                              ),
                              dropdownColor: Colors.grey[50],
                              icon: Icon(Icons.keyboard_arrow_down),
                              value: data[index]["city"],
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black
                              ),
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  data[index]["city"] = newValue!;
                                });
                              },
                              items: cities,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        padding: EdgeInsets.only(left: 6),
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: ListTile(
                          title: Text(
                            "${DateFormat('dd/MM/yyyy').format(data[index]["day"])}",
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
                                  data[index]["day"] = pickedDate;
                                });
                              });
                              },
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        padding: EdgeInsets.only(left: 6),
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: ListTile(
                          title: Text(
                            "${data[index]["time"].format(context)}",
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.timer_rounded),
                            onPressed: () {
                             final DateTime now = DateTime.now();
                             showTimePicker(
                                 context: context,
                                 initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
                             ).then((TimeOfDay? value) {
                               if (value != null) {
                                setState(() {
                                  data[index]["time"] = value;
                                });
                               }
                             });
                            },
                          ),
                        ),
                      ),
                      Container(
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
                          decoration: const InputDecoration(
                            hintText: "Quantity of passengers",
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
                          controller: data[index]["controllers4"][0],
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              fontSize: 20
                          ),
                          expands: false,
                          maxLines: 2,
                        ),
                      ),
                      Container(
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
                          decoration: const InputDecoration(
                            hintText: "From",
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
                          controller: data[index]["controllers4"][1],
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              fontSize: 20
                          ),
                          expands: false,
                          maxLines: 2,
                        ),
                      ),
                      Container(
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
                          decoration: const InputDecoration(
                            hintText: "To",
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
                          controller: data[index]["controllers4"][2],
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              fontSize: 20
                          ),
                          expands: false,
                          maxLines: 2,
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 165,
                        padding: EdgeInsets.only(left: 6),
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration: const InputDecoration(
                            hintText: "The address of the place to pick up from.",
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
                          controller: data[index]["controllers4"][3],
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: TextStyle(
                              fontSize: 20
                          ),
                          expands: false,
                          maxLines: 7,
                        ),
                      ),
                      ]
                    ),
                  ),
                ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.045,
                width: MediaQuery.of(context).size.width*.40,
                child: RaisedButton(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                          width: 10),
                      Text('---  Delete',
                        style: TextStyle(
                            color: Colors.orange
                        ),),
                    ],
                  ),
                  onPressed: (){
                    setState(() {
                        if(i>1) {
                          data.removeAt(i-1);
                          i--;
                        }
                      }
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.red
                      )
                  ),
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height*.045,
                width: MediaQuery.of(context).size.width*.40,
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
                    setState(() {
                      if(i<5) i++;
                      data.add({
                        "direction": 0,
                        "city": city[0],
                        "day": DateTime.now(),
                        "time": TimeOfDay.now(),
                        "controllers4": [
                          for (int i = 0; i < 4; i++)
                            TextEditingController()
                        ],
                      },
                      );
                    });
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
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20)
            ),
            height: MediaQuery.of(context).size.height*.045,
            width: MediaQuery.of(context).size.width*.70,
            child: RaisedButton(
              onPressed: (){},
              child: Text('Submit your application'),
              color: Colors.blue,

            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
      ),
    );
  }
}
