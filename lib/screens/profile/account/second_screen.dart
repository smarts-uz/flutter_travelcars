import 'package:flutter/material.dart';
import 'package:travelcars/app_theme.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool show = false;
  bool _obscureText = false;
  bool _obscureText1 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 127, 26, 1),
        centerTitle: true,
        title: Text(
          "Изменение пароля",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * .1,
              left: 10,
              right: 10),
          height: MediaQuery.of(context).size.height * .9,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Текущий пароль",
                    labelStyle: TextStyle(
                      color: Colors.white10,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          show = !show;
                        });
                      },
                      icon: show
                          ? Icon(Icons.visibility_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                  obscureText: show,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Новый пароль",
                    errorText: null,
                    labelStyle: TextStyle(
                      color: Colors.white10,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(_obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10,top: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Подтверждение нового пароля",
                    errorText: null,
                    labelStyle: TextStyle(
                      color: Colors.white10,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                      child: Icon(_obscureText1
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                  ),
                  obscureText: _obscureText1,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
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
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
