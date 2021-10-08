import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travelcars/app_theme.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic> results = {
    "tarif": [
      'Подача автомобиля в удобное место',
      'Питание водителя',
      'Стоимость топлива',
      'Парковочные платежи',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  //padding: const EdgeInsets.only(top: 30),
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/busmini.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          color: Colors.black,
                        ),
                      ),
                    ],
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.message_rounded,
                            color: MyColor.orange,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              child: Text(
                "Mercedes Sprinter",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, bottom: 3),
                      child: Text(
                        "Год выпуска: 2015г.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
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
                        "ID номер: MS-701AFA",
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
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 16, left: 5),
                      child: Text(
                        "5 387",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.47,
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 4,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.start,
                children: [
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
                ]
                    .map((String name) => Chip(
                          avatar: SvgPicture.asset("assets/icons/globus.svg"),
                          label: Text(
                            name,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(color: HexColor("#F5F5F6")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16,top: 10),
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
                    padding: EdgeInsets.only( bottom: 8, left: 16),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: results["tarif"].length,
                        itemBuilder: (context, i) => Container(
                              height: 30,
                              child: Row(
                                children: [
                                  Icon(Icons.check, color: Colors.green),
                                  SizedBox(width: 5,),
                                  Text(
                                    results["tarif"][i],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 17),
                                  )
                                ],
                              ),
                            )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, bottom: 10,top: 15),
              child: Text(
                "Карта поездки",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Wrap(
                spacing: 16,
                runSpacing: 4,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.start,
                children: [
                  'Чорсу',
                  'Ташкент сити',
                  'Миллий бог',
                  'Гафур Гулям ',
                ]
                    .map((String name) => Chip(
                  avatar: Text("•"),
                  label: Text(
                    name,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ))
                    .toList(),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/map.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 20,
                    right: 20,
                    bottom: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: EdgeInsets.only(left: 16,right: 16,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.orange,
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: (){},
                          child: Text("Посмотреть маршрут",style: TextStyle(color: Colors.white),),
                        )
                      ),
                    )),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 16, bottom: 10,top: 20),
              child: Text(
                "Стоимость поездки за",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),


            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
