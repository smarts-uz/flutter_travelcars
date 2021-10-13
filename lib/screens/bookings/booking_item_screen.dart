import 'package:android_intent/android_intent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travelcars/screens/feedback/feedback.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_theme.dart';

class BookingScreen extends StatefulWidget {
  final drp;
  const BookingScreen({Key? key, this.drp}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final isLoading =true;
  Map<String, dynamic> results = {
    "id": 'MS-701AFA',
    "year": '2015г.',
    "name": 'Mercedes Sprinter',
    "image": 'assets/images/busmini.jpg',
    'map': '',
    'vaqti': ' 07.09.2021',
    'status': 'Одобрено',
    'ekskursiya': 'Ташкент - Экскурсия по городу',
    'bookings':'Бронирование #299',
    'click': '',
    'payme': '',
    'masterCard': '',
    'visa': '',
    'narxi': '1 284 000 UZS',
    'kuni': '1 день',
    "qulaylik": [
      '18 сидений',
      '18 мал. сумок',
      'Кондиционер',
      'Холодильник',
      'Аудиосистема',
      'Люк',
      'Ремни без.',
      'Огнетушитель',
      '14 круп. сумок',
      '2 двери',
      'Микрофон',
      'Телевизор',
      'Откидные сид.',
      'Освещ. в салоне',
      'Аптечка',
    ],
    "tarif": [
      'Подача автомобиля в удобное место',
      'Питание водителя',
      'Стоимость топлива',
      'Парковочные платежи',
    ],
    "eye": '5387',
    "check_box": false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.orange,
        title: Text("${results["bookings"]}",style: TextStyle(
          fontSize: 19,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,color: Colors.white,),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  margin: EdgeInsets.only(
                    bottom: 30,
                  ),
                  width: double.infinity,
                  child: Image.asset(
                    "${results["image"]}",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    bottom: 1,
                    right: 30,
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.amberAccent,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => FeedbackScreen()));
                          },
                          icon: Icon(
                            Icons.message_rounded,
                            color: MyColor.orange,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            _text(text: results["name"]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      child: Text(
                        "Статус:",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 16,
                      ),
                      child: Text(
                        "${results["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 16,top: 15, bottom: 5,),
                  child: Text(
                    "${results["ekskursiya"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, bottom: 5),
                      child: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, bottom: 3),
                      child: Text(
                        "${results["vaqti"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            _listWrap(results['qulaylik']),
            Container(
              decoration: BoxDecoration(color: HexColor("#F5F5F6")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 10),
                    child: Text(
                      "В тарифе включено:",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: results["tarif"].length * 45.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: HexColor("#F5F5F6")),
                    padding: EdgeInsets.only(bottom: 8, left: 16),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: results["tarif"].length,
                      itemBuilder: (context, i) => Container(
                        height: 30,
                        child: Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              results["tarif"][i],
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _text(text: "Стоимость поездки за"),
            Row(
              children: [
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(left: 16,right: 16),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ]),
                      child:Center(
                        child: Text("${results["kuni"]}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: HexColor('#3C3C43'),
                          ),),
                      )
                  ),
                ),
                Flexible(
                  child: Container(
                      padding: EdgeInsets.only(left: 16,right: 16 ),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                            ),
                          ]),
                      child: Center(
                        child: Text("${results["narxi"]}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: HexColor('#3C3C43'),
                          ),),
                      )),
                ),
              ],
            ),
           isLoading? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text(text: "Выберите способ оплаты:"),
                GestureDetector(
                  onTap: (){
                    final intent = AndroidIntent(package: "", action: "action_view");
                    intent.launch();
                  },
                  child: _payment(icon: "assets/icons/Click1.png", name: "Click"),),
                _payment(icon: "assets/icons/online_payme.png", name: "Payme"),
                _payment(icon: "assets/icons/mastercard-2.png", name: "MasterCard"),
                _payment(icon: "assets/icons/visa 1.png", name: "Visa"),
                Row(
                  children: [
                    Checkbox(
                        value: results["check_box"],
                        onChanged: (value) {
                          setState(() {
                            results["check_box"] = value;
                          });
                        }),
                    Container(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Я ознакомлен и согласен с ',
                                style: new TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Политикой\nконфиденциальности ',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch("https://travelcars.uz/rules");
                                  },
                              ),
                              TextSpan(
                                text: 'и',
                                style: new TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: ' Публичной офертой',
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    launch("https://travelcars.uz/publicrules");
                                  },
                              ),
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(16),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: MyColor.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        "Оплатить",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ):Container(),

          ],
        ),
      ),
    );
  }

  Widget _text({text}) {
    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 10, top: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 19,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  Widget _listWrap(List wrap) {
    return Container(
      height: wrap.length * 30,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: wrap.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 50,
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * 0.43,
            child: Chip(
              backgroundColor: Colors.transparent,
              avatar: SvgPicture.asset("assets/icons/globus.svg"),
              label: Text(
                wrap[index],
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _payment({icon, name}) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
            ),
          ]),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 40,
            child: Image.asset(icon),
          ),
          SizedBox(
            width: 15,
          ),
          Center(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 15,
                color: HexColor('#3C3C43'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
