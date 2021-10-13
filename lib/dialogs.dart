import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dialogs {
  static Widget ZayavkaDialog(BuildContext ctx) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        height: 170,
        width: 280,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              child: Image.asset("assets/image.jpg"),
            ),
            Column(
              children: [
                Text(
                  "Ваша заявка принята!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
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
    );
  }

  static Widget OtzivDialog(BuildContext ctx) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        height: 170,
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
                  "Ваш отзыв успешно отправлен!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
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
    );
  }

  static Widget ErrorDialog(BuildContext ctx) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        height: 193,
        width: 280,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              child: SvgPicture.asset(
                "assets/Vector (3).svg",
              ),
            ),
            Column(
              children: [
                Text(
                  "Что - то не так! Проверьте\n соединение с интернетом",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
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

  static Widget TripDialog(BuildContext ctx) {
    return Dialog(
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
    );
  }
}
