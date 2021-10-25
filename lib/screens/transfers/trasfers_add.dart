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
    'A meeting',
    'The wire'
  ];
  int? _radioVal1;
  int? _radioVal2;
  RangeValues _currentRangeValues = RangeValues(10, 500);

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

  DateTime? _selectedDate2 = DateTime.now();

  var number_controller = TextEditingController();
  var number_controller1 = TextEditingController();
  TimeOfDay time = TimeOfDay.now() ;
  int i = 1;

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
                  child:Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    margin:EdgeInsets.all(17),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [0, 1].map((int index) => Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width*.4,
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Radio<int>(
                                  value: index,
                                  groupValue: this._radioVal1,
                                  onChanged: (int? value) {
                                    if (value != null) {
                                      setState(() => this._radioVal1 = value);
                                      print(value);
                                    }
                                    },
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  directions[index],
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
                              value: SelectedVal2,
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.black
                              ),
                              underline: SizedBox(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  SelectedVal2 = newValue!;
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
                            "${DateFormat('dd/MM/yyyy').format(_selectedDate2!)}",
                          ),
                          trailing: IconButton(
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
                                  _selectedDate2 = pickedDate;
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
                            "${time.format(context)}",
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
                                  time = value;
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
                          controller: number_controller,
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
                          controller: number_controller,
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
                          controller: number_controller,
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
                          ), controller: number_controller1,
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
                      if(i>1) i--;
                    });
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
