import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/app_config.dart';
import 'package:travelcars/screens/car/car_category.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class CarTypes extends StatelessWidget {
  final List carslist;

  CarTypes(this.carslist);

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
              size: 25
          ),
        ),
        title: Text(
          LocaleKeys.Auto_types.tr(),
          maxLines: 2,
          style: TextStyle(
              fontSize: 21,
              color: Colors.white
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
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
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_)=>CarCategory(carslist[index]["name"], carslist[index]["meta_url"])
                      )
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                  child: Stack(
                    children: [
                      Container(
                        height: 140,
                        width: MediaQuery.of(context).size.width * .43,
                        child: carslist[index]["image"] == null ? Image.asset(
                          "assets/images/no_car.jpg",
                          fit: BoxFit.contain,
                        ) : Image.network(
                          "${AppConfig.image_url}/car-types/${carslist[index]["image"]}",
                          errorBuilder: (context, error, stackTrace) {
                            print(error);
                            return Image.asset(
                              "assets/images/no_car.jpg",
                              fit: BoxFit.contain,
                            );
                          },
                        ),
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
                        bottom: 10,
                        left: 5,
                        child: Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width * .4,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "${carslist[index]["name"]}",
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
              );
            }
        ),
      ),
    );
  }
}
