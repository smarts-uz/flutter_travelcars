import 'dart:convert';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/login/confirm.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';
import '../../app_config.dart';
import 'components/toast.dart';

class ResetPassword extends StatefulWidget {


  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final TextEditingController _emailController = TextEditingController();
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
            size: 25
          ),
        ),
        title: Text(
          LocaleKeys.Restore_password.tr(),
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
          height: MediaQuery.of(context).size.height*0.9,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 20),
              Text(
                "${LocaleKeys.enter_your_email_or_number.tr()}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    fontFamily: "Poppins"),
              ),
              SizedBox(
                height: 30,
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
              Spacer(),
              GestureDetector(
                onTap: () async {
                  if(_emailController.text.isEmpty) {
                    ToastComponent.showDialog(LocaleKeys.TextField_is_empty.tr());
                    return;
                  }

                  if(_emailController.text.substring(0, 1) == "+") {
                    _emailController.text = _emailController.text.substring(1, _emailController.text.length -1);
                  }

                  String url = "${AppConfig.BASE_URL}/password/forgot";
                  final result = await http.post(
                      Uri.parse(url),
                      body: {
                        'email':'${_emailController.text}'
                      }
                  );
                  print(result.body);
                  int id = json.decode(result.body)["user_id"];
                  int code = json.decode(result.body)['code'];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>Confirm( false,id,code)));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.orange
                  ),
                  height: 40,
                  width: MediaQuery.of(context).size.width * .35,
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
                      SizedBox(width: 10),
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
    );
  }
}
