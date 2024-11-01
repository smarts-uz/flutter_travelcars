import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelcars/screens/login/confirm.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import '../../app_config.dart';
import 'components/toast.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _verifyController = TextEditingController();
  bool show = false;
  bool show1 = false;


  List<String> _items = [LocaleKeys.fizik.tr(), LocaleKeys.yuridik.tr()];
  String _currentItem = LocaleKeys.fizik.tr();



  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    String type = _currentItem == LocaleKeys.fizik.tr() ?"individual" : "legal";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          LocaleKeys.Register_now.tr(),
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                          value: _items[0],
                          groupValue: _currentItem,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentItem = newValue!;
                            });
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _items[0],
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: _items[1],
                          groupValue: _currentItem,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentItem = newValue!;
                            });
                          }),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _items[1],
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Montserrat'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration:  InputDecoration(
                        hintText: "${LocaleKeys.name_surname.tr()}",
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
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 19),
                      expands: false,
                      maxLines: 1,
                      autofocus: false,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration:  InputDecoration(
                        hintText: LocaleKeys.Phone.tr(),
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
                      controller: _emailController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 19),
                      expands: false,
                      maxLines: 1,
                      autofocus: false,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      obscureText: show,
                      autovalidateMode: AutovalidateMode.always,
                      decoration:  InputDecoration(
                        hintText: "${LocaleKeys.password.tr()}",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          icon: !show ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
                        ),
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
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 19),
                      expands: false,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      obscureText: show1,
                      autovalidateMode: AutovalidateMode.always,
                      decoration:  InputDecoration(
                        hintText: "${LocaleKeys.paasword_confirmation.tr()}",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              show1 = !show1;
                            });
                          },
                          icon: !show1 ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
                        ),
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
                      controller: _verifyController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 19),
                      expands: false,
                      maxLines: 1,
                      autofocus: false,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if (_nameController.text.isEmpty || _emailController.text.isEmpty ||_passwordController.text.isEmpty){
                        ToastComponent.showDialog(LocaleKeys.TextField_is_empty.tr());
                        return;
                      }

                      if (_passwordController.text != _verifyController.text ) {
                        ToastComponent.showDialog(LocaleKeys.Password_doesn_match.tr());
                        return;
                      }

                      if(_emailController.text.substring(0, 1) == "+") {
                        _emailController.text = _emailController.text.substring(1, _emailController.text.length -1);
                      }

                      String url = "${AppConfig.BASE_URL}/signup";
                      final result = await http.post(
                          Uri.parse(url),
                          body: {
                            'name':'${_nameController.text}',
                            'email': "${_emailController.text}",
                            'password': "${_passwordController.text}",
                            'password_confirmation' : '${_verifyController.text}',
                            'personality' : '${type}',

                          }
                      );
                      print(result.body);
                      print(result.statusCode);
                      if(result.statusCode == 200) {
                        int id = json.decode(result.body)["user_id"];
                        int code = json.decode(result.body)['code'];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Confirm(true, id, code, password: _passwordController.text,)
                            )
                        );
                      } else {
                        ToastComponent.showDialog("${jsonDecode(result.body)["errors"]}");
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.orange
                      ),
                      height: 40,
                      width: MediaQuery.of(context).size.width * .35,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.next.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19
                            ),
                          ),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward_ios,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
