import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/trip/trip_item.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, int> weather = {
    "Tashkent": 0,
    "Buxoro": 0,
    "Xiva": 0,
    "Samarkand": 0,
  };

  List<dynamic> valyuta = [];
  Map<String, dynamic> index_val = {
    "USD" : 0,
    "EUR": 1,
    "RUB": 2,
    "GBP": 3,
  };

  List<dynamic> imglist = [
    /*{
      'image': "assets/images/tashkent.jpg",
      'text': "Trip to Tashkent",
      "location": "Tashkent",
      "description": "Ташкент - столица Узбекистана, современный город, блещущий великолепием новостроек, но сумевший сохранить и старинную свою часть."
          " Экскурсии по Ташкенту всегда необычны, интересны и увлекательны.",
      "day": 1,
      "time": "5-6",
      "details": "Вы посетите Старый город, где расположен религиозный центр Ташкента – комплекс Хаст-Имам. Именно здесь хранится"
          " знаменитый Коран халифа Османа (VII в.). В Хаст-Имаме вы посетите медресе Барак-хана, мечеть Тилля-Шейха,"
          " мавзолей Абу Бакр Каффаль Шаши и Исламский институт имени Имама аль-Бухари. \n\n Затем вы побываете на одном из старейших "
          "базаров города – Чорсу. После осмотра достопримечательностей Старого города вас ждет поездка на ташкентском метро в центр,"
          " где расположены площадь Амира Тимура, площадь Независимости и Музей прикладного искусства.",
    },
    {
      'image': "assets/images/mountain.jpg",
      'text': "Trip to Mountain",
      "location": "Бельдерсай, Чимган, Чарвак",
      "description": "Таинственные и живописные горы Западного Тянь-Шаня - Большой и Малый Чимган, "
          "горные реки и водопады; урочище Бельдерсай покрытое можжевельником и яблонями, кустами шиповника и барбариса, Чарвакское водохранилище, которое очаровывает каждого путешественника своей красотой.",
      "day": 3,
      "time": "2-1",
      "details": "В 07:00/08:00 встреча в заранее обусловленном месте. Выезд из Ташкента по направлению к Чимганским горам (80 км, 2 ч.). Путь к горам Чимгана пролегает через живописные населенные пункты "
          "Ташкентской области. По приезду в урочище Чимган прогулка по горной местности.\n\nЕсли в ущелье Бельдерсай работает канатная дорога, протяженность которой более 3 км, то можно прокатиться до вершины "
          "горы Кумбель (2400 м), где находится одна из горнолыжных трасс в Узбекистане.",
    },
    {
      'image': "assets/images/samarkand.jpg",
      'text': "Trip to Samarkand",
      "location": "Tashkent",
      "description": "Ташкент - столица Узбекистана, современный город, блещущий великолепием новостроек, но сумевший сохранить и старинную свою часть."
          " Экскурсии по Ташкенту всегда необычны, интересны и увлекательны.",
      "day": 1,
      "time": "5-6",
      "details": "Вы посетите Старый город, где расположен религиозный центр Ташкента – комплекс Хаст-Имам. Именно здесь хранится"
          " знаменитый Коран халифа Османа (VII в.). В Хаст-Имаме вы посетите медресе Барак-хана, мечеть Тилля-Шейха,"
          " мавзолей Абу Бакр Каффаль Шаши и Исламский институт имени Имама аль-Бухари. \n\n Затем вы побываете на одном из старейших "
          "базаров города – Чорсу. После осмотра достопримечательностей Старого города вас ждет поездка на ташкентском метро в центр,"
          " где расположены площадь Амира Тимура, площадь Независимости и Музей прикладного искусства.",
    },
    {
      'image': "assets/images/buxoro.jpg",
      'text': "Trip to Buxoro",
      "location": "Бельдерсай, Чимган, Чарвак",
      "description": "Таинственные и живописные горы Западного Тянь-Шаня - Большой и Малый Чимган, "
          "горные реки и водопады; урочище Бельдерсай покрытое можжевельником и яблонями, кустами шиповника и барбариса, Чарвакское водохранилище, которое очаровывает каждого путешественника своей красотой.",
      "day": 3,
      "time": "2-1",
      "details": "В 07:00/08:00 встреча в заранее обусловленном месте. Выезд из Ташкента по направлению к Чимганским горам (80 км, 2 ч.). Путь к горам Чимгана пролегает через живописные населенные пункты "
          "Ташкентской области. По приезду в урочище Чимган прогулка по горной местности.\n\nЕсли в ущелье Бельдерсай работает канатная дорога, протяженность которой более 3 км, то можно прокатиться до вершины "
          "горы Кумбель (2400 м), где находится одна из горнолыжных трасс в Узбекистане.",
    },
    {
      'image': "assets/images/xiva.jpg",
      'text': "Trip to Xiva",
      "location": "Tashkent",
      "description": "Ташкент - столица Узбекистана, современный город, блещущий великолепием новостроек, но сумевший сохранить и старинную свою часть."
          " Экскурсии по Ташкенту всегда необычны, интересны и увлекательны.",
      "day": 1,
      "time": "5-6",
      "details": "Вы посетите Старый город, где расположен религиозный центр Ташкента – комплекс Хаст-Имам. Именно здесь хранится"
          " знаменитый Коран халифа Османа (VII в.). В Хаст-Имаме вы посетите медресе Барак-хана, мечеть Тилля-Шейха,"
          " мавзолей Абу Бакр Каффаль Шаши и Исламский институт имени Имама аль-Бухари. \n\n Затем вы побываете на одном из старейших "
          "базаров города – Чорсу. После осмотра достопримечательностей Старого города вас ждет поездка на ташкентском метро в центр,"
          " где расположены площадь Амира Тимура, площадь Независимости и Музей прикладного искусства.",
    },
    {
      'image': "assets/images/volley.jpg",
      'text': "Trip to Volley Fergana",
      "location": "Бельдерсай, Чимган, Чарвак",
      "description": "Таинственные и живописные горы Западного Тянь-Шаня - Большой и Малый Чимган, "
          "горные реки и водопады; урочище Бельдерсай покрытое можжевельником и яблонями, кустами шиповника и барбариса, Чарвакское водохранилище, которое очаровывает каждого путешественника своей красотой.",
      "day": 3,
      "time": "2-1",
      "details": "В 07:00/08:00 встреча в заранее обусловленном месте. Выезд из Ташкента по направлению к Чимганским горам (80 км, 2 ч.). Путь к горам Чимгана пролегает через живописные населенные пункты "
          "Ташкентской области. По приезду в урочище Чимган прогулка по горной местности.\n\nЕсли в ущелье Бельдерсай работает канатная дорога, протяженность которой более 3 км, то можно прокатиться до вершины "
          "горы Кумбель (2400 м), где находится одна из горнолыжных трасс в Узбекистане.",
    },*/
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

  List<dynamic> carslist = [
    /*{
      "image": "assets/images/car.jpg",
      "name": "Cars",
      "number": "12",
    },
    {
      "image": "assets/images/microbus.jpg",
      "name": "Microbus",
      "number": "28",
    },
    {
      "image": "assets/images/midbus.jpg",
      "name": "Midibus",
      "number": "32",
    },
    {
      "image": "assets/images/bus.jpg",
      "name": "Bus",
      "number": "8",
    },*/
  ];

  static const city = <String>[
    "Tashkent",
    "Buxoro",
    "Xiva",
    "Samarkand"
  ];
  static const currency = <String>[
    "USD",
    "EUR",
    "RUB",
    "GBP"
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getweather();
    getCars();
    getTrips();
    getvalyuta();
  }

  void getTrips() async{
    String url = "${AppConfig.BASE_URL}/getAllTours";
    final response = await http.get(
      Uri.parse(url)
    );
    setState(() {
      imglist = json.decode(response.body);
    });
  }

  void getCars() async {
    String url = "${AppConfig.BASE_URL}/getAllCarTypes?lang=ru";
    final response  = await http.get(
        Uri.parse(url),
    );
    setState(() {
      carslist = json.decode(response.body)["car_types"];
    });
  }

  void getweather() async {
    for(int i =0; i<city.length; i++) {
      String url = "https://api.openweathermap.org/data/2.5/weather?q=${city[i]}&appid=4d8fb5b93d4af21d66a2948710284366&units=metric";
      final response = await http.get(Uri.parse(url));
      weather["${city[i]}"] = json.decode(response.body)["main"]["temp"].round();
    }
  }
  void getvalyuta() async {
    String url = "https://cbu.uz/uz/arkhiv-kursov-valyut/json/";
    final response = await http.get(Uri.parse(url));
    setState(() {
      valyuta = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TravelCars'),
        automaticallyImplyLeading: false,
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
      body: (imglist.isEmpty || carslist.isEmpty) ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
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
                        hint: Text(
                            "City",
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
                                "Rate change",
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
              items: imglist.map((item) => GestureDetector(
                onTap: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TripItem(item)
                      )
                  );*/
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
                              "https://travelcars.uz/uploads/tours/${item["image"]}",
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
                "Most popular cars to book",
                textAlign: TextAlign.start,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 22
                ),
              ),
            ),
            Container(
              height: (carslist.length / 2).round() * 190,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0
                  ),
                  itemCount: carslist.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      child: Stack(
                        children: [
                          Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width * .43,
                            child: Image.network("https://travelcars.uz/uploads/car-types/${carslist[index]["image"]}"),
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
                    );
                  }
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 12, bottom: 6),
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
