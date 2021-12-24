import 'package:flutter/material.dart';

class CarCategory extends StatelessWidget {

  List<String> names = ["Class", "Places with luggage", "Places without luggage", "Air conditioning"];

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
            padding: EdgeInsets.all(8.0),
            physics: BouncingScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 4,
              child: Container(
                height: MediaQuery.of(context).size.height * .4,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Malibu Turbo"),
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Color.fromRGBO(239, 127, 26, 1),
                            ),
                            child: Center(
                              child: Text(
                                "5",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                            width: 100.0,
                            child: Image.asset("assets/images/malibu.png"),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                            child: ListView.builder(
                                itemCount: 5,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => ListTile(
                                  leading: Icon(Icons.directions_car),
                                  title: Text(
                                    names[index],
                                  ),
                                )
                            ),
                          )
                        ],
                      ),
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
