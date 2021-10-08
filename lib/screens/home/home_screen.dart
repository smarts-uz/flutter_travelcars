import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> imglist = [
    {
      'image': "assets/images/tashkent.jpg",
      'text': "Trip to Tashkent",
    },
    {
      'image': "assets/images/mountain.jpg",
      'text': "Trip to Mountain",
    },
    {
      'image': "assets/images/samarkand.jpg",
      'text': "Trip to Samarkand",
    },
    {
      'image': "assets/images/buxoro.jpg",
      'text': "Trip to Buxoro",
    },
    {
      'image': "assets/images/xiva.jpg",
      'text': "Trip to Xiva",
    },
    {
      'image': "assets/images/volley.jpg",
      'text': "Trip to Volley Fergana",
    },
  ];
  List<Map<String, dynamic>> newslist = [
    {
      'image': "assets/images/news_1.jpg",
      'title': "Достоинства аренды автомобиля с водителем",
      'text': "Собираясь в деловую поездку или на отдых, в незнакомый город или регион, в особенности если вас ждёт длительный перелёт, по дороге в аэропорт хочется, расслабиться, не думая об особенностях вождения. Всё что нужно для этого сделать, это – взять напрокат авто с водителем, который встретит вас прям у дома.",
      'hour': "11:10",
      'date': "05.10.2021"
    },
    {
      'image': "assets/images/news_2.jpeg",
      'title': "Когда услуга аренды авто востребована",
      'text': "В Узбекистане прокат автомобиля с водителем является востребованной услугой, в связи с ростом спроса на туристические услуги в стране.  Вам больше не придется сидеть за рулем при заказе услуги. Менеджеры фирмы Travelcars обеспечат, встречу знакомых, родных, коллег и прочие встречи в аэропорту либо на вокзале в самые короткие сроки.",
      'hour': "06:00",
      'date': "06.10.2021"
    },
  ];
  static const city = <String>[
    "Tashkent",
    "Buxoro",
    "Xiva",
    "Samarkand"
  ];
  static const currency = <String>[
    "USD = 10700",
    "EUR = 11900",
    "RUB = 110",
  ];
  final List<DropdownMenuItem<String>> cities = city.map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
  ).toList();
  final List<DropdownMenuItem<String>> pullar = currency.map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
    ),
  ).toList();
  String? SelectedVal;
  String? SelectedVal2;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TravelCars'),
        actions: [
          IconButton(
              icon: SvgPicture.asset(
                'assets/icons/globus.svg',
                color: Colors.white,
              ),
              onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
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
                      bottom: 15,
                      left: 25,
                      child: DropdownButton(
                        hint: Text(
                            "City",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                            )
                        ),
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
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
                      child: Text(
                        "18",
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                        ),
                      ),
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
                        child: ListTile(
                          title: Text(
                            "Rate change",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                          subtitle: Text(
                            "${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 20,
                        child: DropdownButton(
                          hint: Text(
                              "Currency",
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
                      Positioned(
                        top: 20,
                        right: 15,
                        child: Column(
                          children: [
                            SvgPicture.asset('assets/icons/progress.svg'),
                            SizedBox(height: 5),
                            Text(
                              "19%",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
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
              height: 65,
              width: double.infinity,
              child: Text(
                "Transport services among all cities of Uzbekistan: travel and business",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: 150,
              width: double.infinity,
              child: Image.asset("assets/images/banner.jpg", fit: BoxFit.cover,),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, top: 12, bottom: 6),
              child: Text(
                "Most popular routes",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 24
                ),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    }
                    );
                  }
                  ),
              items: imglist.map((item) =>
                  GestureDetector(
                    onTap: () {

                      },
                    child: Stack(
                        children: [
                          Card(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 6,
                              child: Image.asset(item["image"],
                                fit: BoxFit.cover,
                              )
                          ),
                          Positioned(
                            bottom: 23.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                item["text"],
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
                "Most popular cars to book",
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 22
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CarsCard("assets/images/car.jpg", "Cars", 12),
                    CarsCard("assets/images/microbus.jpg", "Microbus", 28),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CarsCard("assets/images/midbus.jpg", "Midibus", 32),
                    CarsCard("assets/images/bus.jpg", "Bus", 8),
                  ],
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 12, top: 12, bottom: 6),
              child: Text(
                "News and special offers",
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
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 2),
                    disableCenter: true,
                ),
                items: newslist.map((item) =>
                    InkWell(
                      onTap: () {

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
                                    child: Image.asset(
                                      item["image"],
                                      fit: BoxFit.cover,
                                    )
                                ),
                                Text(
                                  item["title"],
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  item["text"],
                                  maxLines: 5,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        item["hour"]
                                    ),
                                    Text(
                                        item["date"]
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
}

class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
class CurrencyCard extends StatelessWidget {
  const CurrencyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Stack(
        
      ),
    );
  }
}



