import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/dummy_data/cars.dart';
import 'package:travelcars/dummy_data/cities_list.dart';
import 'package:travelcars/screens/car/car_category.dart';
import 'package:travelcars/screens/car/car_type.dart';
import 'package:travelcars/screens/po_puti/po_puti.dart';
import 'package:travelcars/screens/profile/account/choice_language.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/screens/trip/trip_item.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static bool isLoading = true;
  static List<dynamic> countries_list = [];
  static List<dynamic> cars_list = [];
  static List<dynamic> city_list = [];
  static List<dynamic> tour_list = [];
  static List<dynamic> options_list = [];
  static List<dynamic> tariff_list = [];
  static Map<String, dynamic> category_list = {};
  static List<dynamic> kurs = [];
  static String? SelectedVal;

  static List<String> city = [];

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<dynamic> imglist = [];
  static List<dynamic> newslist = [];
  static List<dynamic> carslist = [];

  static Map<String, int> weather = {
    "${LocaleKeys.tashkent.tr()}": 0,
    "${LocaleKeys.buxoro.tr()}": 0,
    "${LocaleKeys.xiva.tr()}": 0,
    "${LocaleKeys.samarkand.tr()}": 0,
    "${LocaleKeys.nukus.tr()}": 0,
    "${LocaleKeys.navoiy.tr()}": 0,
    "${LocaleKeys.karshi.tr()}": 0,
    "${LocaleKeys.termiz.tr()}": 0,
    "${LocaleKeys.jizzax.tr()}": 0,
    "${LocaleKeys.guliston.tr()}": 0,
    "${LocaleKeys.andijon.tr()}": 0,
    "${LocaleKeys.fargona.tr()}": 0,
    "${LocaleKeys.namangan.tr()}": 0,
  };
  static List<DropdownMenuItem<String>> cities = [];

  static List<dynamic> valyuta = [];
  static const currency = <String>[
    "RUB",
    "UZS",
    "EUR",
  ];
  static final List<DropdownMenuItem<String>> pullar = currency.map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
    ),).toList();
  static String? SelectedVal2;

  int _current = 0;
  double pul = 0.0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    if(HomeScreen.isLoading) {
      HomeScreen.city = <String>[
        LocaleKeys.tashkent.tr(),
        LocaleKeys.buxoro.tr(),
        LocaleKeys.xiva.tr(),
        LocaleKeys.samarkand.tr(),
        LocaleKeys.nukus.tr(),
        LocaleKeys.navoiy.tr(),
        LocaleKeys.termiz.tr(),
        LocaleKeys.guliston.tr(),
        LocaleKeys.andijon.tr(),
        LocaleKeys.fargona.tr(),
        LocaleKeys.namangan.tr(),
        LocaleKeys.karshi.tr(),
        LocaleKeys.jizzax.tr(),
      ];
      weather = {
        "${LocaleKeys.tashkent.tr()}": 0,
        "${LocaleKeys.buxoro.tr()}": 0,
        "${LocaleKeys.xiva.tr()}": 0,
        "${LocaleKeys.samarkand.tr()}": 0,
        "${LocaleKeys.nukus.tr()}": 0,
        "${LocaleKeys.navoiy.tr()}": 0,
        "${LocaleKeys.karshi.tr()}": 0,
        "${LocaleKeys.termiz.tr()}": 0,
        "${LocaleKeys.jizzax.tr()}": 0,
        "${LocaleKeys.guliston.tr()}": 0,
        "${LocaleKeys.andijon.tr()}": 0,
        "${LocaleKeys.fargona.tr()}": 0,
        "${LocaleKeys.namangan.tr()}": 0,
      };
      cities = HomeScreen.city.map((String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      )).toList();
      getTrips();
      getCars();
      getnews();
      getvalyuta();
      getweather();
      getcities();
      getOptionsTariffs();
      getCountries();
    }
  }

  void getTrips() async{
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getAllTours?lang=${SplashScreen.til}");
    final response = await http.get(url);
    HomeScreen.tour_list = json.decode(response.body)["data"];
    imglist = json.decode(response.body)["data"];
  }

  void getCars() async {
    HomeScreen.cars_list = await Cars.getcars();
    carslist = HomeScreen.cars_list;
    HomeScreen.category_list = await Cars.getcategories(carslist);
    setState(() {
      HomeScreen.isLoading = false;
    });
  }
  
  void getOptionsTariffs() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/caroption?locale=${SplashScreen.til}");
    final response = await http.get(url);
    List<dynamic> temp_data = json.decode(response.body)["data"];
    temp_data.forEach((element) {
      HomeScreen.options_list.add({
        "id": element["id"],
        "name": element["name"],
        "chosen": false
      });
    });
    url = Uri.parse("${AppConfig.BASE_URL}/routeoption?locale=${SplashScreen.til}");
    final result = await http.get(url);
    temp_data = json.decode(result.body)["data"];
    temp_data.forEach((element) {
      HomeScreen.tariff_list.add({
        "id": element["id"],
        "name": element["name"],
        "chosen": false
      });
    });
  }

  void getcities() async {
    HomeScreen.city_list = await Cities.getcities();
    HomeScreen.city_list = HomeScreen.city_list.toSet().toList();
  }

  void getnews () async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/news?lang=${SplashScreen.til}");
    final response = await http.get(url);
    newslist = json.decode(response.body);
  }

  void getvalyuta() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getCurrency");
    final response = await http.get(url);
    valyuta = json.decode(response.body);
    HomeScreen.kurs = valyuta;
  }

  void getweather() async {
    for(int i =0; i<HomeScreen.city.length; i++) {
      Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${HomeScreen.city[i]}&appid=4d8fb5b93d4af21d66a2948710284366&units=metric");
      var response = await http.get(url);
      if(jsonDecode(response.body)["cod"] == "404") {
        Uri another_url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Qarshi&appid=4d8fb5b93d4af21d66a2948710284366&units=metric");
        final another_response = await http.get(another_url);
        weather["${HomeScreen.city[i]}"] = json.decode(another_response.body)["main"]["temp"].round();
      } else {
        weather["${HomeScreen.city[i]}"] = json.decode(response.body)["main"]["temp"].round();
      }
    }
    setState(() {

    });
  }
  
  void getCountries() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getCountries");
    final response = await http.get(url);
    HomeScreen.countries_list = jsonDecode(response.body)["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TravelCars",
          style: TextStyle(
            fontSize: 23,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
               Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (_) => AccountChoicePage()
                   )
               );
              },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/po_puti.svg',
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => PoPutiScreen()
                  )
              );
            },
          )
        ],
      ),
      body: HomeScreen.isLoading ? Center(
          child: CircularProgressIndicator()
      ) : SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * .45,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(204, 243, 255, 1),
                                Color.fromRGBO(56, 163, 197, 1),
                              ]
                          )
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 25,
                      child: DropdownButton(
                        menuMaxHeight: MediaQuery.of(context).size.height * .35,
                        hint: Text(
                            LocaleKeys.city.tr(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white
                            )
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        focusColor: Colors.white,
                        dropdownColor: Colors.grey[300],
                        value: HomeScreen.SelectedVal,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => HomeScreen.SelectedVal = newValue);
                          }},
                        items: cities,
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 30,
                      child: Container(
                          height: 40,
                          width: 40,
                          child: SvgPicture.asset("assets/icons/weather.svg", fit: BoxFit.contain,)
                      ),
                    ),
                    Positioned(
                        right: 25,
                        top: 35,
                        child: Text(
                          "°C",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )
                    ),
                    Positioned(
                      right: 50,
                      top: 40,
                      child: weather["${HomeScreen.SelectedVal}"] != null ? Text(
                        "${weather["${HomeScreen.SelectedVal}"]}",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ) : Text(" "),
                    )
                  ],
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * .45,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 14),
                  child: Stack(
                    children: [
                      Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 250, 241, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      ),
                      Positioned(
                        top: 15,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .45,
                          alignment: Alignment.center,
                          child: Text(
                           LocaleKeys.Rate_change.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          )
                        ),
                      ),
                      Positioned(
                          bottom: 50,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .45,
                            alignment: Alignment.center,
                            child: Text(
                              pul == 0 ? "1\$ = " : "1\$ = $pul",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 17
                              ),
                            ),
                          )
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .45,
                          alignment: Alignment.center,
                          child: DropdownButton(
                            menuMaxHeight: MediaQuery.of(context).size.height * .4,
                            hint: Text(
                                LocaleKeys.Currency.tr(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                )
                            ),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            focusColor: Colors.white,
                            dropdownColor: Colors.grey[300],
                            value: SelectedVal2,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  SelectedVal2 = newValue;
                                  valyuta.forEach((element) {
                                    if(element["code"] == newValue) {
                                      pul = element["rate"].toDouble();
                                    }
                                  });
                                });
                              }},
                            items: pullar,
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
            Container(
              color: Color.fromRGBO(245, 245, 246, 1),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Text(
                LocaleKeys.home_screen_Transport_services.tr(),
                maxLines: 10,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, top: 12, bottom: 6),
              child: Text(
                LocaleKeys.Most_popular_routes.tr(),
                textAlign: TextAlign.center,
                maxLines: 10,
                style: TextStyle(
                    fontSize: 19
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: false,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    }
                    );
                  }
                  ),
              items: imglist.map((item) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TripItem(item)
                      )
                  );
                },
                child: Stack(
                    children: [
                      Container(
                        height: 571,
                        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "${AppConfig.image_url}/tours/${item["image"]}",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      Positioned(
                        bottom: 12.0,
                        child: Container(
                          height: 70,
                          alignment: Alignment.bottomLeft,
                          width: MediaQuery.of(context).size.width * .8,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            "${item["name"]}",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              )
             ).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imglist.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(239, 127, 26, 1).withOpacity(_current == entry.key ? 0.9 : 0.4)
                    )
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 8, top: 20, right: 8),
              child: Text(
               LocaleKeys.Most_popular_cars_book.tr(),
                textAlign: TextAlign.center,
                maxLines: 10,
                style: TextStyle(
                    fontSize: 19
                ),
              ),
            ),
            Container(
              height: 340.0,
              margin: EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CarsCard(carslist[0]["image"], carslist[0]["name"], carslist[0]["quantity"], carslist[0]["meta_url"]),
                      CarsCard(carslist[1]["image"], carslist[1]["name"], carslist[1]["quantity"], carslist[1]["meta_url"])
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CarsCard(carslist[2]["image"], carslist[2]["name"], carslist[2]["quantity"], carslist[2]["meta_url"]),
                      CarsCard(carslist[3]["image"], carslist[3]["name"], carslist[3]["quantity"], carslist[3]["meta_url"])
                    ],
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CarTypes(carslist)
                    )
                );
              },
              child: Container(
                height: 40.0,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 17.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text(
                  LocaleKeys.see_all.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 5, right: 15),
              child: Text(
               LocaleKeys.News_and_special_offers.tr(),
                maxLines: 10,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 19
                ),
              ),
            ),
            Container(
              height: 350,
              child: CarouselSlider(
                options: CarouselOptions(
                    autoPlay: false,
                    //autoPlayInterval: Duration(seconds: 2),
                    disableCenter: true,
                ),
                items: newslist.map((item) =>
                    InkWell(
                      onTap: () {
                        launch("https://travelcars.uz/news/${item["meta_url"]}");
                       // Navigator.push(context,MaterialPageRoute(builder: (_)=>DetailScreen()));
                        },
                      child: Container(
                        margin: EdgeInsets.all(6),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    child:Image.network(
                                      "${AppConfig.image_url}/pages/${item["thumb"]}",
                                    ),
                                ),

                                Text(
                                  item["short"],
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        item["created_at"].substring(0,10)
                                    ),
                                    Text(
                                        item["created_at"].substring(11,16)
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ).toList(),
              ),
            )
          ],
        ),
      )
    );
  }
}

class CarsCard extends StatelessWidget {
  final String image;
  final int number;
  final String name;
  final String meta_url;

  CarsCard(this.image, this.name, this.number, this.meta_url);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CarCategory(name, meta_url)
            )
        );
      },
      child: Container(
        height: 170,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          child: Stack(
            children: [
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width * .43,
                child: Image.network("${AppConfig.image_url}/car-types/$image"),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color.fromRGBO(239, 127, 26, 1),
                    ),
                    child: Center(
                      child: Text(
                        "$number",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                        ),
                      ),
                    )
                ),
              ),
              Positioned(
                bottom: 10,
                left: 5,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .4,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}