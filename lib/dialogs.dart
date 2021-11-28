import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dialogs {
  static Future<dynamic> ZayavkaDialog(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
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
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
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
                    padding: const EdgeInsets.only(top: 12),
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
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            height: MediaQuery.of(ctx).size.height * .25,
            width: MediaQuery.of(ctx).size.width * .85,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/assets/error.svg.jpg"),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Что - то не так! Проверьте\n соединение с интернетом",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          letterSpacing: 0.15),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
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

  static Future<dynamic> TripDialog(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (BuildContext dialogContext) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            height: 266,
            width: 280,
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
                      margin: EdgeInsetsDirectional.only(
                        top: 13,
                      ),
                      height: 60,
                      color: Color.fromRGBO(255, 250, 241, 1),
                      child: Column(
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
                                  "assets/Vector (5).svg",
                                ),
                                Text("07.09.2021"),
                              ],
                            ),
                          ),
                        ],
                      ),
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
