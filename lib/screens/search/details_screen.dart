import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController name_controller = TextEditingController();
  final TextEditingController additional_controller = TextEditingController();
  bool logo_check = false;
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();
  int _current = 0;
  int narx_index = 0;
  late String dropdown;
  String? overtime_cost;
  List<int> car_options = [];
  List<int> route_options = [];
  List<dynamic> narxlar = [];
  List<dynamic> costlar = [];
  List<dynamic> pricelar = [];
  String selectedVal = LocaleKeys.Cash_driver.tr();
  List<dynamic> payment_types = [
    {
      "text":  LocaleKeys.Cash_driver.tr(),
      "type": "pay_cash_driver",
    },
    {
      "text":  LocaleKeys.Cash_company.tr(),
      "type": "pay_cash_company",
    },
    {
      "text":  LocaleKeys.Online_payment.tr(),
      "type": "online",
    },
    {
      "text":  LocaleKeys.Cashless_payments.tr(),
      "type": "pay_bank",
    }
  ];
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
          "day": "${day == 0.5 ? day : day.toInt()} ${SplashScreen.til == "ru" ? day == 1.0 ? LocaleKeys.day.tr() : "дня" : LocaleKeys.day.tr()}",
          "cost": cost
        });
      } else if(key == "overtime") {
        if(value != null) {
          if(value is String) {
            overtime_cost = "${double.parse(value) * app_kurs} ${SplashScreen.kurs}";
          } else {
            overtime_cost = "${value * app_kurs} ${SplashScreen.kurs}";
          }

        }
      }
    });
    dropdown = narxlar[0]["day"];


    jsonDecode(widget.route_item["cost_data"]).forEach((key, value) {
      if(value != null && value != 0) {
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
        costlar.add({
          "day": day == 0.5 ? day : day.toInt(),
          "cost": value != null ? value : 0
        });
      }
    });

    jsonDecode(widget.route_item["price_data"]).forEach((key, value) {
      if(value != null && value != 0 && key != "overtime") {
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
        pricelar.add({
          "day": day == 0.5 ? day : day.toInt(),
          "cost": value != null ? value : 0
        });
      }
    });

    for(int i = 0; i < widget.route_item["car"]['car_options'].length; i++) {
      car_options.add(i);
    }
    for(int i = 0; i < widget.route_item["route_options"].length; i++) {
      route_options.add(i);
    }

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
          height: 280,
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.Cancellation_terms.tr(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red
                  ),
                ),
                Divider(),
                Text(
                  '${widget.route_item["company"]["refund"]}',
                  maxLines: 60,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red
                  ),
                ),
              ],
            ),
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
          height: 80,
          margin: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.important_information.tr(),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orangeAccent
                  ),
                ),
                Divider(),
                Text(
                  overtime_cost != null ? "${LocaleKeys.important1.tr()} – $overtime_cost\n" : ""
                      "${LocaleKeys.important2.tr()} - ${widget.refund}",
                  textAlign: TextAlign.justify,
                  maxLines: 10,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.orangeAccent
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPicker(BuildContext cont) {
    showModalBottomSheet(
        context: cont,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(LocaleKeys.Photo_library.tr()),
                      onTap: () async {
                        final pickedImageFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 100,
                          maxWidth: 150,
                        );
                        File file = File(pickedImageFile!.path);
                        setState(() {
                          _pickedImage = file;
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(LocaleKeys.Camera.tr()),
                    onTap: () async {
                      final pickedImageFile = await _picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 100,
                        maxWidth: 150,
                      );
                      File file = File(pickedImageFile!.path);
                      setState(() {
                        _pickedImage = file;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
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
                              onError: (error, stackTrace) {
                                Image.asset(
                                  "assets/images/no_car.jpg",
                                  fit: BoxFit.cover,
                                );
                              }
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
                  bottom: -20,
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
                  padding: EdgeInsets.only(left: 13, bottom: 3),
                  child: Text(
                    "${LocaleKeys.year_of_issue.tr()}: ${results["car"]["year"]}\n${LocaleKeys.id_number.tr()}: ${results["car"]["uid"]}",
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
                          fontSize: 15,
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
            Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Column(
                children: car_options.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      results["car"]['car_options'][e]["image"] == null ? Image.asset(
                        "assets/images/no_car.jpg",
                        fit: BoxFit.contain,
                      ) : Image.network(
                        "${AppConfig.image_url}/car-options/${results["car"]['car_options'][e]["image"]}",
                        width: 25,
                        height: 25,
                        errorBuilder: (context, error, stackTrace) {
                          print(error);
                          return Image.asset(
                            "assets/images/no_car.jpg",
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          results["car"]['car_options'][e]["name"],
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
            if(widget.points.isNotEmpty) Container(
              height: MediaQuery.of(context).size.height * 0.45,
              padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
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
            if(results["route_options"].isNotEmpty) Container(
              decoration: BoxDecoration(color: HexColor("#F5F5F6")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _text(text: LocaleKeys.Included_in_type.tr(), top: 8.0),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: HexColor("#F5F5F6")),
                      padding: EdgeInsets.only(top: 5, left: 16),
                      child: Column(
                        children: route_options.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            children: [
                              Icon(Icons.check, color: Colors.green),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  results["route_options"][e]["name"],
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          ),
                        )).toList(),
                      )
                  ),
                ],
              ),
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
                  dropdownColor: Colors.grey[50],
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: selectedVal,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black
                  ),
                  isExpanded: true,
                  underline: SizedBox(),
                  onChanged: (String? newValue) {
                    print(newValue);
                    setState(() {
                      selectedVal = newValue!;
                    });
                  },
                  items: payments,
                ),
              ),
            ),
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 16),
              child: TextButton(
                onPressed: () {
                  _otmen(context);
                },
                child: Text(
                  LocaleKeys.Cancellation_terms.tr(),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 16, bottom: 5),
              child: TextButton(
                onPressed: () {
                  _inform(context);
                },
                child: Text(
                  LocaleKeys.important_information.tr(),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            TFF(additional_controller, LocaleKeys.additional_info.tr(), 120),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (bool? newValue) {
                      setState(() {
                        logo_check = newValue!;
                      });
                    },
                    value: logo_check,
                  ),
                  Expanded(
                    child: Text(
                      LocaleKeys.needPoster.tr(),
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                  )
                ],
              ),
            ),
            if(logo_check) TFF(name_controller, LocaleKeys.guestName.tr(), 45),
            if(logo_check) Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width * .4,
                    margin: EdgeInsets.symmetric(vertical: 7.0),//MediaQuery.of(context).size.width * .2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image:   _pickedImage != null ?
                        DecorationImage(
                          image: FileImage(_pickedImage!),
                        ) : DecorationImage(
                            image: AssetImage("assets/images/no_image.png"))
                    ),
                  ),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width * .6,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showPicker(context);
                          },
                          child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * .5,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    LocaleKeys.upload.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _pickedImage = null;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * .5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 25,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  LocaleKeys.delete.tr(),
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 20
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                if(prefs.containsKey("userData")) {
                  if(logo_check) {
                    if(name_controller.text.isEmpty || additional_controller.text.isEmpty) {
                      ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}");
                      return;
                    }

                    if(_pickedImage == null) {
                      ToastComponent.showDialog(LocaleKeys.no_image.tr());
                      return;
                    }
                  }

                  String pay_key = "";
                  for(var element in payment_types) {
                    if(element["text"] == selectedVal) {
                      pay_key = element["type"];
                    }
                  }
                  if(pay_key.isEmpty) {
                    ToastComponent.showDialog(LocaleKeys.choose_pay.tr());
                    return;
                  }

                  String price = "0";
                  String cost = "0";
                  pricelar.forEach((element) {
                    if("${element["day"]} ${LocaleKeys.day.tr()}" == dropdown) {
                      price = element["cost"].toString();
                    }
                  });

                  costlar.forEach((element) {
                    if("${element["day"]} ${LocaleKeys.day.tr()}" == dropdown) {
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

                  if(logo_check) {
                    if(name_controller.text.isEmpty) {
                      ToastComponent.showDialog("${LocaleKeys.TextField_is_empty.tr()}");
                      return;
                    }
                    if(_pickedImage == null) {
                      ToastComponent.showDialog("${LocaleKeys.no_image.tr()}");
                      return;
                    }
                  }

                  http.BaseRequest request;
                  String token = json.decode(prefs.getString('userData')!)["token"];
                  if(logo_check) {
                    request = http.MultipartRequest('POST', Uri.parse("${AppConfig.BASE_URL}/book/create"))
                      ..headers["Authorization"] = 'Bearer $token'
                      ..fields['route_price_id'] = "${results["route_price_id"]}"
                      ..fields['cost'] = "$cost"
                      ..fields['price'] = '$price'
                      ..fields['pay_key'] = '$pay_key'
                      ..fields['additional'] = '${additional_controller.text}'
                      ..fields['with_poster'] = '1'
                      ..fields['poster_name'] = '${name_controller.text}'
                      ..files.add(
                          await http.MultipartFile.fromPath(
                              'poster_logo',
                              '${_pickedImage?.path}',
                              contentType: MediaType(
                                  'image', 'jpg'
                              )
                          )
                      );
                  } else {
                    request = http.MultipartRequest('POST', Uri.parse("${AppConfig.BASE_URL}/book/create"))
                      ..headers["Authorization"] = 'Bearer $token'
                      ..fields['route_price_id'] = "${results["route_price_id"]}"
                      ..fields['cost'] = "$cost"
                      ..fields['price'] = '$price'
                      ..fields['pay_key'] = '$pay_key'
                      ..fields['additional'] = '${additional_controller.text}'
                      ..fields['with_poster'] = '0';
                  }
                  try{
                    var response = await request.send();
                    print(response.reasonPhrase);
                    print(response.statusCode);
                    if(response.statusCode == 200) {
                      Dialogs.ZayavkaDialog(context);
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
                      fontSize: 20,
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

  Widget _text({text, top = 25.0}) {
    return Container(
      padding: EdgeInsets.only(left: 13, top: top),
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

  Widget TFF(TextEditingController controller, String hint, double height) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.always,
        decoration: InputDecoration(
          hintText: hint,
          hintMaxLines: 4,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        controller: controller,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        style: TextStyle(
            fontSize: 17
        ),
        expands: false,
        maxLines: 7,
      ),
    );
  }
}

