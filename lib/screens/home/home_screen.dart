import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  List<Map<String, dynamic>> carslist = [
    {
      'image': "assets/images/malibu.svg",
      'text': "Cars",
      'number': "12",
    },
    {
      'image': "assets/images/",
      'text': "Microbus",
      'number': "28",
    },
    {
      'image': "assets/images/midibus.svg",
      'text': "Midibus",
      'number': "32",
    },
    {
      'image': "assets/images/",
      'text': "Bus",
      'number': "8",
    },
  ];
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
            Container(
              color: Color.fromRGBO(245, 245, 246, 1),
              padding: EdgeInsets.all(8),
              height: 60,
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
                    });
                  }
                  ),
              items: imglist.map((item) =>
                  GestureDetector(
                    onTap: () {

                      },
                    child: Stack(
                        children: [
                          Container(
                              padding: EdgeInsets.all(8),
                              child: Image.asset(item["image"], fit: BoxFit.cover, width: 1000)),
                          Positioned(
                            bottom: 17.0,
                            left: 0.0,
                            right: 0.0,
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
                    width: 12.0,
                    height: 12.0,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CarsCard("assets/images/car.jpg", "Cars", 12),
                    CarsCard("assets/images/microbus.jpg", "MicroBus", 28),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CarsCard("assets/images/midbus.jpg", "Midibus", 32),
                    CarsCard("assets/images/bus.jpg", "Bus", 8),
                  ],
                )
              ],
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
    return Container(
      child: SvgPicture.asset(image),
    );
  }
}

