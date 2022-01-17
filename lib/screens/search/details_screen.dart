import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelcars/dialogs.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/login/components/toast.dart';
import 'package:travelcars/screens/profile/reviews.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

import '../../app_config.dart';


class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> route_item;
  final Map<String, Location> points;
  final String refund;

  DetailScreen(this.route_item, this.points, this.refund);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = true;
  final CarouselController _controller = CarouselController();
  int _current = 0;
  int narx_index = 0;
  late String dropdown;
  String overtime_cost = "0 USD";
  List<dynamic> narxlar = [];
  List<dynamic> costlar = [];
  List<dynamic> pricelar = [];
  List<dynamic> payment_types = [
    {
      "text": "Online payment",
      "type": "online",
    },
    {
      "text": "Cashless payments",
      "type": "pay_bank",
    },
    {
      "text": "Cash company",
      "type": "pay_cash_company",
    },
    {
      "text": "Cash driver",
      "type": "pay_cash_driver",
    },
  ];
  String? selectedVal;
  final List<DropdownMenuItem<String>> payments = [];


  final Map<MarkerId, Marker> markers = {};

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  final List<String> _adresses = [];
  Completer<GoogleMapController> _mapController = Completer();
  double origin_lat = 0;
  double origin_lng = 0;

  @override
  void initState() {
    super.initState();
    payment_types.forEach((element) {
      payments.add( DropdownMenuItem<String>(
        value: element["text"],
        child: Text(element["text"]),
      ),);
    });
    double app_kurs = 1;
    HomeScreen.kurs.forEach((element) {
      if(SplashScreen.kurs == element["code"]) {
        app_kurs = element["rate"].toDouble();
      }
    });

    double day = 1.0;
    jsonDecode(widget.route_item["price_data"]).forEach((key, value) {
      if(key != "overtime" && value != null) {
        double cost;
        if(value.runtimeType == String) {
          cost = double.parse(value) * app_kurs;
        } else {
          cost = value * app_kurs;
        }
        day = 1.0;
        switch(key) {
          case "one":
            day = 1.0;
            break;
          case "two":
            day = 2.0;
            break;
          case "three":
            day = 3.0;
            break;
          case "half":
            day = 0.5;
        }
        narxlar.add({
          "day": "${day == 0.5 ? day : day.toInt()} day",
          "cost": cost
        });
      } else if(key == "overtime") {
        overtime_cost = "$value USD";
      }
    });
    dropdown = narxlar[0]["day"];


    jsonDecode(widget.route_item["cost_data"]).forEach((key, value) {
      costlar.add({
        "day": day == 0.5 ? day : day.toInt(),
        "cost": value != null ? value : 0
      });
    });

    jsonDecode(widget.route_item["price_data"]).forEach((key, value) {
      pricelar.add({
        "day": day == 0.5 ? day : day.toInt(),
        "cost": value != null ? value : 0
      });
    });

    drawPolyLine();
  }

  Future<void> drawPolyLine() async {
    bool first = true;
    double temp_origin_lat = 0;
    double temp_origin_lng = 0;
    int indexc = 0;
    for(var entry in widget.points.entries) {
      indexc=indexc+1;

      //put markers
      MarkerId markerId = MarkerId(UniqueKey().toString());
      Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            entry.value.latitude,
            entry.value.longitude,
          ),
          infoWindow: InfoWindow(title: entry.key)
      );
      markers[markerId] = marker;

      //get addresses
      _adresses.add(entry.key);
      if(first) {
        origin_lat = entry.value.latitude;
        origin_lng = entry.value.longitude;
        temp_origin_lat = entry.value.latitude;
        temp_origin_lng = entry.value.longitude;
        first = false;
      } else {
        //draw polyline
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyBfclKdBDMynmFFZo9LcFpNS0gmrkLMttE",
          PointLatLng(temp_origin_lat, temp_origin_lng),
          PointLatLng(entry.value.latitude, entry.value.longitude),
          travelMode: TravelMode.driving,
        );
        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }
        PolylineId id = PolylineId("poly");
        Polyline polyline = Polyline(
            polylineId: id,
            color: Colors.lightBlueAccent,
            width: 4,
            points: polylineCoordinates);
        polylines[id] = polyline;
        temp_origin_lat = entry.value.latitude;
        temp_origin_lng = entry.value.longitude;
      }
    }

    setState(() {
      isLoading = false;
    });
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
                LocaleKeys.Cancellation_terms.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
              Divider(),
              Text(
                '${widget.route_item["company"]["refund"]}',
                maxLines: 12,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red
                ),
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
          height: MediaQuery.of(ctx).size.height * 0.1,
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.important_information.tr(),
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent
                ),
              ),
              Divider(),
              Text(
                //'${widget.route_item["company"]["important"]}',
                "Овертайм за 1 час – $overtime_cost\nКомиссия за банковский перевод - ${widget.refund}",
                textAlign: TextAlign.justify,
                maxLines: 5,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> results = widget.route_item;
    return Scaffold(
      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ): SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 24),
                  height: MediaQuery.of(context).size.height * .4,
                  width: double.infinity,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: false,
                        disableCenter: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                    items: results["car"]["images"].map<Widget>((item) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "${AppConfig.image_url}/cars/${item["original"]}",
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
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  right: 25,
                  bottom: -25,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Reviews(route_price_id: results["route_price_id"],)
                          )
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 30,
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: results["car"]["images"].asMap().entries.map<Widget>((entry) {
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
            _text(text: results["car"]["title"]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 3),
                  child: Text(
                    "${LocaleKeys.year_of_issue.tr()}: ${results["car"]["year"]}\nID номер: ${results["car"]["uid"]}",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 18, left: 5),
                      child: Text(
                        "${results["car"]["views"]}",
                        style: TextStyle(
                          fontSize: 14,
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
            _listWrap(results["car"]['car_options']),
            if(results["route_options"].isNotEmpty) Container(
              decoration: BoxDecoration(color: HexColor("#F5F5F6")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 10, bottom: 0),
                    child: Text(
                      "${LocaleKeys.Included_in_the_tariff.tr()}: ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Container(
                    height: results["route_options"].length * 35.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: HexColor("#F5F5F6")),
                    padding: EdgeInsets.only(top: 5, left: 16),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: results["route_options"].length,
                      itemExtent: 28,
                      itemBuilder: (context, i) => Row(
                        children: [
                          Icon(Icons.check, color: Colors.green),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            results["route_options"][i]["name"],
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
            /*if(widget.points.isNotEmpty) _text(text: "${LocaleKeys.trip_mapp.tr()}"),
            if(widget.points.isNotEmpty) Container(
              margin: EdgeInsets.only(left: 16),
              height: _adresses.length * 30,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _adresses.length,
                  itemExtent: 28,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Text(
                    "* ${_adresses[index]}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                    ),
                  )),
            ),*/
            if(widget.points.isNotEmpty) Container(
              height: MediaQuery.of(context).size.height * 0.45,
              padding: const EdgeInsets.only(left: 16, right: 16),
              width: double.infinity,
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
                markers: Set<Marker>.of(markers.values),
                polylines: Set<Polyline>.of(polylines.values),
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(origin_lat, origin_lng),
                  zoom: 14.4746,
                ),
                  gestureRecognizers: < Factory < OneSequenceGestureRecognizer >> [
                    new Factory < OneSequenceGestureRecognizer > (
                          () => new EagerGestureRecognizer(),
                    ),
                  ].toSet()
              ),
            ),
            _text(text: "${LocaleKeys.travel_cost_for.tr()}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.grey[50],
                          icon: Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          underline: SizedBox(),
                          value: dropdown,
                          onChanged: (newValue) {
                            int newIndex = 0;
                            narxlar.forEach((element) {
                              if(element["day"] == newValue) {
                                setState(() {
                                  dropdown = newValue!;
                                  narx_index = newIndex;
                                });
                              }
                              newIndex++;
                            });
                          },
                          items: narxlar.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value['day'],
                              child: Text(
                                value['day'],
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15,
                                  color: HexColor('#3C3C43'),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
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
                        child: Text(
                          "${narxlar[narx_index]["cost"].toStringAsFixed(2)} ${SplashScreen.kurs}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: HexColor('#3C3C43'),
                          ),
                        ),
                      )
                  ),
                )
              ],
            ),
            _text(text: "${LocaleKeys.choose_the_payment_type.tr()}"),
            Container(
              width: double.infinity,
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 12),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  menuMaxHeight: MediaQuery.of(context).size.height * .5,
                  hint: Text(
                      LocaleKeys.Payment.tr(),
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black
                      )
                  ),
                  dropdownColor: Colors.grey[50],
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: selectedVal,
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black
                  ),
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedVal = newValue!;
                    });
                  },
                  items: payments,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: TextButton(
                onPressed: () {
                  _otmen(context);
                },
                child: Text(
                  LocaleKeys.Cancellation_terms.tr(),
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
              padding: EdgeInsets.only(left: 16, bottom: 5),
              child: TextButton(
                onPressed: () {
                  _inform(context);
                },
                child: Text(
                  LocaleKeys.important_information.tr(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                if(prefs.containsKey("userData")) {
                  String pay_key = "";
                  for(var element in payment_types) {
                    if(element["text"] == selectedVal) {
                      pay_key = element["type"];
                    }
                  }
                  /*switch(selectedVal) {
                    case "Online payment":
                      pay_key = "online";
                      break;
                    case "Cashless payments":
                      pay_key = "pay_bank";
                      break;
                    case "Cash company":
                      pay_key = "pay_cash_company";
                      break;
                    case "Cash driver":
                      pay_key = "pay_cash_driver";
                      break;
                  }*/
                  if(pay_key.isEmpty) {
                    ToastComponent.showDialog("Choose payment type");
                    return;
                  }
                  String token = json.decode(prefs.getString('userData')!)["token"];
                  Uri url = Uri.parse("${AppConfig.BASE_URL}/book/create");
                  String price = "0";
                  String cost = "0";
                  pricelar.forEach((element) {
                    if(element["day"] + " day" == dropdown) {
                      price = element["cost"];
                    }
                  });

                  costlar.forEach((element) {
                    if(element["day"] + " day" == dropdown) {
                      if(element["cost"] is String) {
                        cost = element["cost"];
                      } else {
                        cost = element["cost"].toString();
                      }

                    }
                  });
                  print({
                    "route_price_id": "${results["route_price_id"]}",
                    "cost": "$cost",
                    "price": "$price",
                    "pay_key": "$pay_key",
                  });
                  try{
                    final response = await http.post(
                        url,
                        headers: {
                          "Authorization": "Bearer $token"
                        },
                        body: {
                          "route_price_id": "${results["route_price_id"]}",
                          "cost": "$cost",
                          "price": "$price",
                          "pay_key": "$pay_key",
                        },
                    );
                    print(response.body);
                    if(jsonDecode(response.body)["success"]) {
                      //Dialogs.ZayavkaDialog(context);
                      Navigator.pop(context);
                    } else {
                      Dialogs.ErrorDialog(context);
                    }
                  } catch(error) {
                    print(error);
                    Dialogs.ErrorDialog(context);
                  }
                } else {
                  Dialogs.LoginDialog(context);
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                alignment: Alignment.center,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    LocaleKeys.book.tr(),
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
        ),
      ),
    );
  }

  Widget _text({text}) {
    return Container(
      padding: EdgeInsets.only(left: 15, bottom: 10, top: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
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
      height: wrap.length * 27,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: wrap.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 50,
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * 0.43,
            child: Chip(
              backgroundColor: Colors.transparent,
              avatar: SvgPicture.asset("assets/icons/globus.svg"),
              label: Text(
                wrap[index]["name"],
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
