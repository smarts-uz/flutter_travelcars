import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstSceen extends StatefulWidget {
  @override
  _FirstSceenState createState() => _FirstSceenState();
}

class _FirstSceenState extends State<FirstSceen> {
  List<String> sort = ["Физическое лицо", "Юридическое лицо"];
  int? _radioVal2;

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
              height: MediaQuery.of(context).size.height * 3 / 4,
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
                    SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.5),
                          ),
                          width: 326,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFld(
                                  title: "Email", hint: "nimadir@gmail.com"),
                              SizedBox(height: 33),
                              TextFld(title: "ФИО", hint: "John Frederik"),
                              SizedBox(height: 33),
                              TextFld(
                                  title: "Телефон", hint: "+998(__) ___ __ __"),
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
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Юридическое название",
                                        errorText: null,
                                        labelStyle: TextStyle(
                                          color: Colors.white10,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Юридический город",
                                        errorText: null,
                                        labelStyle: TextStyle(
                                          color: Colors.white10,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Юридический адрес",
                                        errorText: null,
                                        labelStyle: TextStyle(
                                          color: Colors.white10,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                width: 326,
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Почтовый индекс",
                                        errorText: null,
                                        labelStyle: TextStyle(
                                          color: Colors.white10,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "Банк",
                                        errorText: null,
                                        labelStyle: TextStyle(
                                          color: Colors.white10,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Расчетный счет",
                                    errorText: null,
                                    labelStyle: TextStyle(
                                      color: Colors.white10,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "ОКЭД",
                                    errorText: null,
                                    labelStyle: TextStyle(
                                      color: Colors.white10,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "МФО",
                                    errorText: null,
                                    labelStyle: TextStyle(
                                      color: Colors.white10,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: "ИНН",
                                        errorText: null,
                                        labelStyle: TextStyle(
                                          color: Colors.white10,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 17),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.5),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "ОКОНХ",
                                    errorText: null,
                                    labelStyle: TextStyle(
                                      color: Colors.white10,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Сохранить"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextFld({title, hint}) {
    return TextFormField(
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
