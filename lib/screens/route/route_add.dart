import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:travelcars/screens/transfers/trasfers_add.dart';
class RouteAdd extends StatefulWidget {
  const RouteAdd({Key? key}) : super(key: key);

  @override
  _RouteAddState createState() => _RouteAddState();
}

class _RouteAddState extends State<RouteAdd> {


  String? SelectedVal1;
  String? SelectedVal2;
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

  DateTime? _selectedDate2 = DateTime.now();

  var number_controller = TextEditingController();
  var number_controller1 = TextEditingController();

  List<Map<String, dynamic>> data = [
    {
      "city1": city[0],
      "city2": city[0],
      "day": DateTime.now(),
      "controllers2": [
        for (int i = 0; i < 2; i++)
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
            onPressed: () {},
          )
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
                  child:Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    margin:EdgeInsets.all(17),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Text('Trip ${index + 1}',
                              style: TextStyle(
                                  fontSize: 25  ,
                                  fontWeight: FontWeight.bold
                              ),),
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
                            child:DropdownButtonHideUnderline(
                              child: Container(
                                child: DropdownButton<String>(
                                  hint: Text(
                                      "City",
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.black
                                      )
                                  ),
                                  dropdownColor: Colors.grey[50],
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  value: data[index]["city1"],
                                  isExpanded: true,
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black
                                  ),
                                  underline: SizedBox(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      data[index]["city1"] = newValue!;
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
                            padding: EdgeInsets.only(left: 6, right: 6),
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: DropdownButton<String>(
                              hint: Text(
                                  "City",
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Colors.black
                                  )
                              ),
                              dropdownColor: Colors.grey[50],
                              icon: Icon(Icons.keyboard_arrow_down),
                              value: data[index]["city2"],
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black
                              ),
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  data[index]["city2"] = newValue!;
                                });
                              },
                              items: cities,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 55,
                            padding: EdgeInsets.only(left: 8),
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${DateFormat('dd/MM/yyyy').format(data[index]["day"])}",
                                  style: TextStyle(
                                    fontSize: 16
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2018),
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
                              ],
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
                              controller: data[index]["controllers2"][0],
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
                              controller: data[index]["controllers2"][1],
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
                          "city1": city[0],
                          "city2": city[0],
                          "day": DateTime.now(),
                          "controllers2": [
                            for (int i = 0; i < 2; i++)
                              TextEditingController()
                          ],
                        },);
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
                  borderRadius: BorderRadius.circular(4)
              ),
              height: MediaQuery.of(context).size.height*.04,
              width: MediaQuery.of(context).size.width*.80,
              child: RaisedButton(
                onPressed: (){},
                child: Text('Submit your application'),
                color: Colors.blue,

              ),
            )
          ],
        ),
      ),
    );
  }
}
