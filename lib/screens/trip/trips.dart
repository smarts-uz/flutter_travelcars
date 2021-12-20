import 'package:flutter/material.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/trip/trip_item.dart';

class TripsScreen extends StatelessWidget {
  List<dynamic> trips_list = HomeScreen.tour_list;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tours",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: ListView.builder(
          itemCount: trips_list.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TripItem(trips_list[index])
                    )
                );
              },
              child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://travelcars.uz/uploads/tours/${trips_list[index]["image"]}",
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
                          "${trips_list[index]["name_en"]}",
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
        ),
      ),
    );
  }
}
