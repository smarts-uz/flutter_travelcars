import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:travelcars/app_theme.dart';
import 'package:travelcars/map.dart';
import 'package:travelcars/screens/bookings/booking_item_screen.dart';
import 'package:travelcars/screens/feedback/feedback.dart';
import 'package:travelcars/screens/search/components/drop_button_cost.dart';
import 'package:travelcars/screens/trip/trip_item.dart';


class CarDetails extends StatefulWidget {
  final Map<String,dynamic> info;
  CarDetails(this.info);
  final CarouselController _controller = CarouselController();

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

void _otmen(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.3,
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Условия отмены',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
              Divider(),
              Text(
                'Заказчик может отменить свою бронь БЕЗ\n ШТРАФА при след. условиях:\n'
                '- при бронировании автомобиля за 2-3 месяцев\n и более до начала поездки - за 15 дней;\n'
                '- при бронировании автомобиля за 30 дней до\n начала поездки - за 10 дней;\n'
                '- при бронировании автомобиля за 14 дней до\n начала поездки - за 7 дней;\n'
                '- при бронировании автомобиля за 7 дней до\n начала поездки - за 3 дня;\n'
                '- при бронировании автомобиля за 3 дней до\n начала поездки - за 24 часа.\n',
                maxLines: 12,
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ],
          ),
        );
      },
  );
}

void _inform(BuildContext ctx) {
  showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return Container(
          height: MediaQuery.of(ctx).size.height * 0.15,
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Важная информация',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 15, color: Colors.orangeAccent),
              ),
              Divider(),
              Text(
                'Овертайм за 1 час – 0 UZS\n'
                ' Комиссия за банковский перевод - 5%',
                maxLines: 5,
                style: TextStyle(fontSize: 14, color: Colors.orangeAccent),
              )
            ],
          ),
        );
      },
  );
}

class _CarDetailsState extends State<CarDetails> {




  @override
  Widget build(BuildContext context) {
    var results = widget.info;
    List<dynamic> images = results["images"];
    print(images);

    int _current = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24),
                  height: 330,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                        autoPlay: true,
                        //autoPlayInterval: Duration(seconds: 2),
                        disableCenter: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          }
                          );
                        }
                    ),
                   items: results["images"].map<Widget>((item) {
                     return Container(
                      // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                       width: double.infinity,
                       decoration: BoxDecoration(
                         image: DecorationImage(
                           image: NetworkImage(
                             "https://travelcars.uz/uploads/cars/$item",
                           ),
                           fit: BoxFit.cover,
                         ),
                         borderRadius: BorderRadius.all(Radius.circular(15)),
                       ),
                     );
                   }
                   ).toList(),
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
                 bottom: 6,
                 right: 160,
                 child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: results["images"].asMap().entries.map<Widget>((entry) {
                   return GestureDetector(
                     //onTap: () => _controller.animateToPage(entry.key),
                     child: Container(
                         width: 8.0,
                         height: 8.0,
                         margin: EdgeInsets.symmetric(horizontal: 4.0),
                         decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4)
                         )
                     ),
                   );
                 }).toList(),
               ),),
                Positioned(
                    bottom: 6,
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
            _text(text: results["title"]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, bottom: 3),
                      child: Text(
                        "Год выпуска: ${results["year"]}",
                        style: TextStyle(
                          fontSize: 16,
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
                        "ID номер: ${results["number"]}",
                        style: TextStyle(
                          fontSize: 16,
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
                      padding: EdgeInsets.only(right: 18 , left: 5),
                      child: Text(
                        "${results["views"]}",
                        style: TextStyle(
                          fontSize: 17,
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
           /* _listWrap(results['qulayliklar']),
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
            ),*/
           /* _text(text: "Карта поездки"),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: const EdgeInsets.only(left: 16, right: 16),
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
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => MapScreen()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.orange,
                      ),
                      child: Center(
                        child: Text(
                          "Посмотреть маршрут",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _text(text: "Стоимость поездки за"),
            DrpBtnCost(),
            Container(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: TextButton(
                onPressed: () {
                  _otmen(context);
                },
                child: Text(
                  "Условия отмены",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, bottom: 16),
              child: TextButton(
                onPressed: () {
                  _inform(context);
                },
                child: Text(
                  "Важная информация",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),*/
            GestureDetector(
              onTap: () {
               /* Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BookingScreen()));*/
              },
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
                    "Бронировать",
                    style: TextStyle(
                      fontSize: 17,
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
          fontSize: 22,
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
}

/*Map<String, dynamic>  info = {
    "id": 'MS-701AFA',
    "year": '2015г.',
    "name": 'Mercedes Sprinter',
    "image": 'assets/images/busmini.jpg',
    'map': '',
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
    "marshrut": [
      'Чорсу',
      'Ташкент сити',
      'Миллий бог',
      'Гафур Гулям ',
    ],
    "eye": '5387',}*/
