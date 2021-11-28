import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dialogs {
  static Future<dynamic> ZayavkaDialog(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Container(
            height: MediaQuery.of(ctx).size.height * .25,
            width: MediaQuery.of(ctx).size.width * .85,
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image.jpg"),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                Text(
                  "Ваша заявка принята!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      letterSpacing: 0.15),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      "Закрыть",
                      style: TextStyle(
                        color: Color.fromRGBO(239, 127, 26, 1),
                        fontSize: 24
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> OtzivDialog(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (BuildContext dialogContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Container(
              height: MediaQuery.of(ctx).size.height * .3,
              width: MediaQuery.of(ctx).size.width * .85,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/image.jpg"),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Ваш отзыв успешно отправлен!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            letterSpacing: 0.15),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pop(ctx);
                        },
                      child: Text(
                        "Закрыть",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(239, 127, 26, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        );
  }

  static Future<dynamic> ErrorDialog(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (BuildContext dialogContext) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            height: MediaQuery.of(ctx).size.height * .30,
            width: MediaQuery.of(ctx).size.width * .85,
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child:  SvgPicture.asset("assets/error.svg", fit: BoxFit.cover),
                ),
                Column(
                  children: [
                    Text(
                      "Что - то не так! Проверьте\n соединение с интернетом",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          letterSpacing: 0.15),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      "Повторить",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(239, 127, 26, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  static Future<dynamic> TripDialog(
      BuildContext ctx,
      List routes,
      ) {
    return showDialog(
        context: ctx,
        builder: (BuildContext dialogContext) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            height: MediaQuery.of(ctx).size.height * .30,
            width: MediaQuery.of(ctx).size.width * .85,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: Image.asset(
                    "assets/image.jpg",
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Ваш запрос успешно принят к рассмотрению",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          letterSpacing: 0.15),
                    ),
                    Container(
                      height: MediaQuery.of(ctx).size.height * .1,
                      child: ListView.builder(
                          itemCount: routes.length,
                          itemBuilder: (context, index) =>  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ташкент - Экскурсия по городу",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    letterSpacing: 0.15),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 94),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/clock.svg",
                                    ),
                                    Text("07.09.2021"),
                                  ],
                                ),
                              ),
                            ],
                          ),),
                    ),

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text(
                      "Закрыть",
                      style: TextStyle(
                        color: Color.fromRGBO(239, 127, 26, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
