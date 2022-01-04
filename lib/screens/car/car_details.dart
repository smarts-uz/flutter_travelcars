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