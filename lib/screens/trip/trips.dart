import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/home/home_screen.dart';
import 'package:travelcars/screens/trip/trip_item.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class TripsScreen extends StatelessWidget {
  List<dynamic> trips_list = HomeScreen.tour_list;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.tours.tr(),
          maxLines: 2,
          style: TextStyle(
              color: Colors.white,
              fontSize: 21
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: ListView.builder(
            itemCount: trips_list.length,
            padding: EdgeInsets.symmetric(vertical: 3.0),
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
                      height: 225,
                      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "${AppConfig.image_url}/tours/${trips_list[index]["image"]}",
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    Positioned(
                      bottom: 12.0,
                      child: Container(
                        height: 120,
                        alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width * .8,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          "${trips_list[index]["name"]}",
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
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
