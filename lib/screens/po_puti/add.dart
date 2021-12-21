import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  DateTime day = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  List text_controllers =  [
    for (int i = 0; i < 5; i++)
      TextEditingController()
  ];

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    final pickedImageFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    File file = File(pickedImageFile!.path);
    setState(() {
      _pickedImage = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create advert",
          style: TextStyle(
            fontSize: 25,
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
      ),
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            margin:EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TFF("From", text_controllers[0], 55),
                TFF("To", text_controllers[1], 55),
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
                TFF("Quantity without baggage", text_controllers[2], 55),
                TFF("Quantity within baggage", text_controllers[3], 55),
                TFF("Comment", text_controllers[4], 155),
                Row(
                  children: [
                    Container(
                      height: 120, //MediaQuery.of(context).size.height * .2,
                      width: 120,
                      margin: EdgeInsets.symmetric(horizontal: 9.0, vertical: 7.0),//MediaQuery.of(context).size.width * .2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image:  _pickedImage != null ?
                        DecorationImage(
                          image: FileImage(_pickedImage!),
                        ) : DecorationImage(
                            image: AssetImage("assets/images/no_image.png"))
                      ),
                    ),
                    Container(
                      height: 120,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * .45,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Upload',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _pickedImage = null;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * .45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey
                                )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 25,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 25
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  height: MediaQuery.of(context).size.height * .045,
                  width: MediaQuery.of(context).size.width * .8,
                  child:  RaisedButton(
                    onPressed: ()  {
                    },
                    child: Text(
                      'Publish',
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
          ),
        ),
      ),
    );
  }
  Widget TFF (String? hintText, TextEditingController controller, double height) {
    return Container(
      width: double.infinity,
      height: height,
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
