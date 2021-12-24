import 'package:flutter/material.dart';
import 'package:travelcars/screens/home/cars_list.dart';

class CarCategory extends StatelessWidget {

  List<Map<String, dynamic>> names = [
    {
      "name": "Class",
      "icon": Icons.directions_car
    },
    {
      "name": "Places with luggage",
      "icon": Icons.people_outline
    },
    {
      "name": "Places without luggage",
      "icon": Icons.home_repair_service_outlined
    },
    {
      "name": "Air conditioning",
      "icon": Icons.ac_unit_outlined
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 28
          ),
        ),
        title: Text(
          'Auto type',
          style:TextStyle(
              fontSize: 25,
              color: Colors.white
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            padding: EdgeInsets.only(top: 10.0),
            physics: BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CarsList("name", 2)
                    )
                );*/
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5
                  )
                ),
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 18.0, top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Malibu Turbo",
                            style: TextStyle(
                              fontSize: 20.0
                            ),
                          ),
                          Container(
                              height: 27,
                              width: 27,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Color.fromRGBO(239, 127, 26, 1),
                              ),
                              child: Center(
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .17,
                          width: MediaQuery.of(context).size.width * .32,
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image.asset(
                            "assets/images/malibu.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .16,
                          width: MediaQuery.of(context).size.width * .5,
                          padding: EdgeInsets.only(right: 3.0),
                          child: ListView.builder(
                              itemCount: 4,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      names[index]["icon"],
                                      color: Colors.orange,
                                      size: 27.0,
                                    ),
                                    Text(
                                      names[index]["name"],
                                      style: TextStyle(
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
