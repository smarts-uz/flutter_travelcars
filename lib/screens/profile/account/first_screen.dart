import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app_theme.dart';
import '../../../mask.dart';

class FirstSceen extends StatefulWidget {
  @override
  _FirstSceenState createState() => _FirstSceenState();
}

class _FirstSceenState extends State<FirstSceen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<String> sort = ["Физическое лицо", "Юридическое лицо"];
  int? _radioVal2;
  List<TextEditingController> controllers = [
    for (int i = 0; i < 9; i++)
      TextEditingController()
  ];
  List<String> hints =
  [
  "Юридическое название",
  "Юридический город",
  "Юридический адрес",
  "Почтовый индекс",
  "Банк",
  "Расчетный счет",
  "ОКЭД",
  "МФО",
  "ИНН",
  "ОКОНХ",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text("Изменение профиля"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .81,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 10),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("assets/Image.png"),
                          ),
                          Positioned(
                            right: 10,
                            left: 15,
                            bottom: 40,
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset("assets/Vector.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 40, right: 16, left: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.5),
                      ),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFld(
                              title: "Email", hint: "nimadir@gmail.com",controller: _emailController,),
                          SizedBox(height: 33),
                          TextFld(title: "ФИО", hint: "John Frederik",controller: _nameController,),
                          SizedBox(height: 33),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              MaskedTextInputFormatter(mask: '### ## ### ## ##', separator: ' '),
                            ],
                            decoration: InputDecoration(
                              labelText:"Телефон",
                              hintText: '___ __ ___ __ __',
                              prefixText:'+' ,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [0, 1]
                                  .map((int index) => Container(
                                        alignment: Alignment.centerLeft,
                                        height: 40,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Radio<int>(
                                              value: index,
                                              groupValue: this._radioVal2,
                                              onChanged: (int? value) {
                                                if (value != null) {
                                                  setState(() => this
                                                      ._radioVal2 = value);
                                                  print(value);
                                                }
                                              },
                                            ),
                                            Text(
                                              sort[index],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Column(
                            children: [0, 1, 2, 3,4,5,6,7,8,].map((e) => Container(
                              width: double.infinity,
                              height:  50,
                              padding: EdgeInsets.only(left: 15),
                              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                decoration: InputDecoration(
                                  hintText: hints[e],
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
                                controller: controllers[e],
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    fontSize: 20
                                ),
                                expands: false,
                              ),
                            ),).toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: MyColor.blue),
                height: 40,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Сохранить",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextFld({title, hint,controller,}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        border: OutlineInputBorder(),
      ),
    );
  }
}
