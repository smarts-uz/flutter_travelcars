import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/dummy_data/cars.dart';
import 'package:travelcars/dummy_data/cities_list.dart';
import 'package:travelcars/screens/car/car_category.dart';
import 'package:travelcars/screens/car/car_type.dart';
import 'package:travelcars/screens/po_puti/po_puti.dart';
import 'package:travelcars/screens/trip/trip_item.dart';
import 'package:http/http.dart' as http;
import 'package:travelcars/screens/trip/trips.dart';
import 'package:travelcars/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static List<dynamic> cars_list = [];
  static List<dynamic> city_list = [];
  static List<dynamic> tour_list = [];
  static List<dynamic> options_list = [];
  static List<dynamic> tariff_list = [];
  static Map<String, dynamic> category_list = {};
  static double kurs_dollar = 0;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static bool isLoading = true;

  static List<dynamic> imglist = [];
  static List<dynamic> newslist = [];
  static List<dynamic> carslist = [];

  static Map<String, int> weather = {
    "Tashkent": 0,
    "Buxoro": 0,
    "Xiva": 0,
    "Samarkand": 0,
    "Nukus": 0,
    "Navoiy": 0,
    "Qarshi": 0,
    "Termiz": 0,
    "Jizzax": 0,
    "Guliston": 0,
    "Andijon": 0,
    "Farg'ona": 0,
    "Namangan": 0,
  };
  static const city = <String>[
    "Tashkent",
    "Buxoro",
    "Xiva",
    "Samarkand",
    "Nukus",
    "Navoiy",
    "Qarshi",
    "Termiz",
    "Jizzax",
    "Guliston",
    "Andijon",
    "Farg'ona",
    "Namangan",
  ];
  static final List<DropdownMenuItem<String>> cities = city.map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
      )).toList();
  static String? SelectedVal;

  static List<dynamic> valyuta = [];
  static Map<String, dynamic> index_val = {
    "USD" : 0,
    "EUR": 1,
    "RUB": 2,
  };
  static const currency = <String>[
    "USD",
    "EUR",
    "RUB",
  ];
  static final List<DropdownMenuItem<String>> pullar = currency.map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
    ),).toList();
  static String? SelectedVal2;

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    if(isLoading) {
      getTrips();
      getnews();
      getCars();
      getOptionsTariffs();
      getcities();
      getvalyuta();
      getweather();
    }
  }

  void getTrips() async{
    Uri url = Uri.parse("${AppConfig.BASE_URL}/getAllTours?lang=ru");
    final response = await http.get(url);
    HomeScreen.tour_list = json.decode(response.body)["data"];
    imglist = json.decode(response.body)["data"];
  }

  void getCars() async {
    HomeScreen.cars_list = await Cars.getcars();
    carslist = HomeScreen.cars_list;
    setState(() {
      isLoading = false;
    });
    HomeScreen.category_list = await Cars.getcategories(carslist);
  }
  
  void getOptionsTariffs() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/caroption?locale=ru");
    final response = await http.get(url);
    List<dynamic> temp_data = json.decode(response.body)["data"];
    temp_data.forEach((element) {
      HomeScreen.options_list.add({
        "id": element["id"],
        "name": element["name"],
        "chosen": false
      });
    });
    url = Uri.parse("${AppConfig.BASE_URL}/routeoption?locale=ru");
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
    Uri url = Uri.parse("${AppConfig.BASE_URL}/news?lang=ru");
    final response = await http.get(url);
    newslist = json.decode(response.body);
  }

  void getvalyuta() async {
    Uri url = Uri.parse("https://cbu.uz/uz/arkhiv-kursov-valyut/json/");
    final response = await http.get(url);
    valyuta = json.decode(response.body);
    HomeScreen.kurs_dollar = double.parse(valyuta[0]["Rate"]);
  }

  void getweather() async {
    for(int i =0; i<city.length; i++) {
      Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=${city[i]}&appid=4d8fb5b93d4af21d66a2948710284366&units=metric");
      final response = await http.get(url);
      weather["${city[i]}"] = json.decode(response.body)["main"]["temp"].round();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TravelCars",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/icons/globus.svg',
                color: Colors.white,
              ),
              onPressed: () {
               Navigator.push(
                   context,
                   CupertinoPageRoute(
                       builder: (_) => TripsScreen()
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
      body: isLoading ? Center(
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
                      height: 130,
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
                                fontSize: 18,
                                color: Colors.white
                            )
                        ),
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                        focusColor: Colors.white,
                        dropdownColor: Colors.grey[300],
                        value: SelectedVal,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => SelectedVal = newValue);
                          }},
                        items: cities,
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 30,
                      child: Container(
                          height: 45,
                          width: 45,
                          child: SvgPicture.asset("assets/icons/weather.svg", fit: BoxFit.contain,)
                      ),
                    ),
                    Positioned(
                        right: 25,
                        top: 35,
                        child: Text(
                          "°C",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                    ),
                    Positioned(
                      right: 45,
                      top: 30,
                      child: weather["$SelectedVal"] != null ? Text(
                        "${weather["$SelectedVal"]}",
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                        ),
                      ) : Text(" "),
                    )
                  ],
                ),
                Container(
                  height: 130,
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
                          child: Column(
                            children: [
                              Text(
                               LocaleKeys.Rate_change.tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),
                              ),
                              Text(
                                "${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      Positioned(
                          bottom: 35,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .45,
                            alignment: Alignment.center,
                            child: Text(
                              SelectedVal2 != null ?
                              "${valyuta[index_val[SelectedVal2]]["Rate"]}"  //".substring(0, valyuta[index_val[SelectedVal2]]["Rate"].indexOf("."),)}"
                                  : " ",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 25
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
                                setState(() => SelectedVal2 = newValue);
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
              height: 85,
              width: double.infinity,
              child: Text(
                LocaleKeys.home_screen_Transport_services.tr(),
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, top: 12, bottom: 6),
              child: Text(
                LocaleKeys.Most_popular_routes.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            "${item["name"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
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
            Container(
              padding: EdgeInsets.only(left: 12, top: 12, bottom: 6),
              child: Text(
               LocaleKeys.Most_popular_cars_book.tr(),
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 22
                ),
              ),
            ),
            Container(
              height: 370.0,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext ctx, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(
                            builder: (_) => CarCategory(carslist[index]["name"], carslist[index]["meta_url"])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 4,
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width * .43,
                              child: Image.network("${AppConfig.image_url}/car-types/${carslist[index]["image"]}"),
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
                                      "${carslist[index]["quantity"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17
                                      ),
                                    ),
                                  )
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              left: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .4,
                                alignment: Alignment.center,
                                child: Text(
                                  "${carslist[index]["name"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
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
                  "See all",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, bottom: 6),
              child: Text(
               LocaleKeys.News_and_special_offers.tr(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 24
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

  CarsCard(this.image, this.name, this.number);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Stack(
        children: [
          Container(
            height: 140,
            width: MediaQuery.of(context).size.width * .43,
            child: Image.asset(image),
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
            left: 60,

            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget WeatherCard() {
    return Container(
      height: 150,
      width: double.infinity * .45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(204, 243, 255, 1),
              Color.fromRGBO(56, 163, 197, 1),
            ]
        ),
      ),
      child: Stack(
        children: [
          ListTile(
            leading: Text("Tashkent"),
            trailing: Icon(Icons.expand_more_rounded),
          ),
          Positioned(
              top: 10,
              left: 5,
              child: SvgPicture.asset("assets/icons/weather.svg")
          ),
          Positioned(
              top: 10,
              right: 5,
              child: Text("18 C")
          )
        ],
      ),
    );
  }
}