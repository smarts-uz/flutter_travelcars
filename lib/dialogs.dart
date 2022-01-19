import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travelcars/screens/login/choice_language.dart';
import 'package:travelcars/screens/login/login_srcreen.dart';
import 'package:travelcars/screens/po_puti/po_puti.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

class Dialogs {
  static Future<dynamic> ZayavkaDialog(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Container(
            height: 150,
            width: 240,
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image.jpg"),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                Text(
                  "${LocaleKeys.Your_application_is_accepted.tr()}!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      letterSpacing: 0.15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    LocaleKeys.close.tr(),
                    style: TextStyle(
                      color: Color.fromRGBO(239, 127, 26, 1),
                      fontSize: 17
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
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            content: Container(
              height: 150,
              width: 240,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    margin: EdgeInsets.symmetric(vertical: 5),
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
                        "${LocaleKeys.Your_review_has_been_sent_successfully.tr()}!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            letterSpacing: 0.15),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(ctx);
                      },
                    child: Text(
                      LocaleKeys.close.tr(),
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(239, 127, 26, 1),
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
        builder: (BuildContext dialogContext) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Container(
            height: 175,
            width: 240,
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child:  SvgPicture.asset("assets/error.svg", fit: BoxFit.cover),
                ),
                Column(
                  children: [
                    Text(
                      "${LocaleKeys.Something_is_wrong_Check.tr()}}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          letterSpacing: 0.15),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    LocaleKeys.Repeat.tr(),
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(239, 127, 26, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  static Future<dynamic> TripDialog(BuildContext ctx, List routes,)  {
    return showDialog(
        context: ctx,
        builder: (BuildContext dialogContext) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Container(
            height: 240,
            width: 250,
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image.jpg",),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                Column(
                  children: [
                    Text(
                      LocaleKeys.your_request_has_been_successfully_accepted_for_consideration.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          letterSpacing: 0.15),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      color: Color.fromRGBO(255, 250, 241, 1),
                      height: 55,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: ListView.builder(
                          itemCount: routes.length,
                          itemBuilder: (context, index) =>  Container(
                            height: 45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${routes[index]["from"]} - ${routes[index]["to"]}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                    letterSpacing: 0.15,
                                    height: 1.3,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/clock.svg",
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${routes[index]["date"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        height: 1.3
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(ctx);
                  },
                  child: Text(
                    LocaleKeys.close.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(239, 127, 26, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  static Future<dynamic> LoginDialog(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (BuildContext dialogContext) => AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Container(
            height: 180,
            width: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child:  SvgPicture.asset("assets/error.svg", fit: BoxFit.cover),
                ),
                Column(
                  children: [
                    Text(
                     LocaleKeys.please_login_to_do_this_action.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          letterSpacing: 0.15),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.push(
                        ctx,
                        MaterialPageRoute(
                            builder: (_) => LoginScreen()
                        )
                    );
                  },
                  child: Text(
                    LocaleKeys.go_to_login_page.tr(),
                    style: TextStyle(
                      fontSize: 17,
                      color: Color.fromRGBO(239, 127, 26, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  static Future<dynamic> PoPutiDialog(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          content: Container(
            height: 170,
            width: 240,
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image.jpg"),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Text(
                  "${LocaleKeys.Your_ad_has_been_published.tr()}!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      letterSpacing: 0.15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.pop(ctx);
                    Navigator.pop(ctx);
                    Navigator.push(
                        ctx,
                        CupertinoPageRoute(
                            builder: (_) => PoPutiScreen()
                        )
                    );
                  },
                  child: Text(
                    LocaleKeys.close.tr(),
                    style: TextStyle(
                        color: Color.fromRGBO(239, 127, 26, 1),
                        fontSize: 17
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
}
