import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelcars/screens/login/confirm.dart';
import 'components/toast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _verifyController = TextEditingController();
  bool show = false;

  List<String> _items = ["Физ. лицо", "Юр. лицо"];
  String _currentItem = "Физ. лицо";

  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          "Регистрация",
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Row(
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
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(
                        width: 25,
                      ),
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
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Montserrat'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.only(left: 15),
                   // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        hintText: "ФИО",
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
                      style: TextStyle(fontSize: 20),
                      expands: false,
                      maxLines: 1,
                      autofocus: false,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.only(left: 15),
                  //  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        hintText: "E-mail или телефон",
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
                      style: TextStyle(fontSize: 20),
                      expands: false,
                      maxLines: 1,
                      autofocus: false,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.only(left: 15),
                  //  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      obscureText: show,
                      autovalidateMode: AutovalidateMode.always,
                      decoration:  InputDecoration(
                        hintText: "Пароль",
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
                      style: TextStyle(fontSize: 20),
                      expands: false,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.only(left: 15),
                   // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      obscureText: show,
                      autovalidateMode: AutovalidateMode.always,
                      decoration:  InputDecoration(
                        hintText: "Подтверждение пароля",
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
                      controller: _verifyController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 20),
                      expands: false,
                      maxLines: 1,
                      autofocus: false,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_nameController.text.isEmpty || _emailController.text.isEmpty ||_passwordController.text.isEmpty){
                            ToastComponent.showDialog("TextField is empty", );
                            return;
                          }

                          if (_passwordController.text != _verifyController.text ) {
                            ToastComponent.showDialog("Password doesn't match",);
                            return;
                          }

                          Navigator.push(context, MaterialPageRoute(builder: (_)=>Confirm(true)));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.orange
                          ),
                          height: 40,
                          width: 154,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Далее",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.arrow_forward_ios,color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
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
