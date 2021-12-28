import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/translations/locale_keys.g.dart';


class CarDetails extends StatefulWidget {
  final Map<String,dynamic> info;
  CarDetails(this.info);
  final CarouselController _controller = CarouselController();

  @override
  _CarDetailsState createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> results = widget.info;
    List<dynamic> images = results["images"];
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .92,
            child: SingleChildScrollView(
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
                              autoPlay: false,
                              disableCenter: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                }
                                );
                              }
                          ),
                         items: images.map<Widget>((item) {
                           return Container(
                             width: double.infinity,
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: NetworkImage(
                                   "${AppConfig.image_url}/cars/$item",
                                 ),
                                 fit: BoxFit.cover,
                               ),
                               borderRadius: BorderRadius.only(
                                 bottomLeft: Radius.circular(15),
                                 bottomRight: Radius.circular(15)
                               ),
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
                                size: 30,
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
                          children: images.asMap().entries.map<Widget>((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
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
                        ),
                      ),
                    ],
                  ),
                  _text(text: results["title"]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16, bottom: 5),
                            child: Text(
                              "${LocaleKeys.year_of_issue.tr()} ${results["year"]}",
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
                              "${LocaleKeys.id_number.tr()} ${results["number"]}",
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
                  _listWrap(results['qulayliklar']),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              /* Navigator.push(
                          context, MaterialPageRoute(builder: (_) => BookingScreen()));*/
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  LocaleKeys.reserve.tr(),
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
      height: wrap.length * 50,
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
              LocaleKeys.cancelation_terms.tr(),
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
            Divider(),
            Text(
              '${LocaleKeys.the_customer_can_cancel_his_reservation_WITHOUT}\n ${LocaleKeys.penalty_at_the_next_conditions.tr()}\n'
                  '${LocaleKeys.two_three_month.tr()}\n${LocaleKeys.fiveteendays.tr()}\n'
                  '${LocaleKeys.thirtydays.tr()}\n ${LocaleKeys.tendays.tr()}\n'
                  '${LocaleKeys.fourteendays.tr()}\n ${LocaleKeys.sevendays.tr()}\n'
                  '${LocaleKeys.before_7days.tr()}\n ${LocaleKeys.threedays.tr()}\n'
                  '${LocaleKeys.before_3days.tr()}\n ${LocaleKeys.twenty_four_h.tr()}\n',
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
             LocaleKeys.important_information.tr(),
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 15, color: Colors.orangeAccent),
            ),
            Divider(),
            Text(
              '${LocaleKeys.Overtime_UZS.tr()}\n'
                  ' ${LocaleKeys.five.tr()}',
              maxLines: 5,
              style: TextStyle(fontSize: 14, color: Colors.orangeAccent),
            )
          ],
        ),
      );
    },
  );
}

/*Container(
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
