import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/translations/locale_keys.g.dart';

import '../../app_config.dart';

class InfoScreen extends StatelessWidget {
  final Map<String, dynamic> way_item;

  InfoScreen(this.way_item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${LocaleKeys.Announcement.tr()} #${way_item["id"]}",
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.all(15),
              child: Image.network(
                "${AppConfig.image_url}/Onways/${way_item["image"]}",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 20),
              child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 19,
                      height: 1.7,
                      color: Colors.black
                    ),
                    children: [
                      TextSpan(text: "${LocaleKeys.From.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${way_item["address1"]}\n"),
                      TextSpan(text: "${LocaleKeys.To.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${way_item["address2"]}\n"),
                      TextSpan(text: "${LocaleKeys.Date.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${way_item["date"]}\n"),
                      TextSpan(text: "${LocaleKeys.Time.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${way_item["time"].substring(0, 5)}\n"),
                      TextSpan(text: "${LocaleKeys.Car_type.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${way_item["model_car"]}\n"),
                      TextSpan(text: "${LocaleKeys.Quantity_.tr()} ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${way_item["place"]}\n"),
                      TextSpan(text: "${LocaleKeys.Quantity.tr()} ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "${way_item["place_bag"]}\n"),
                      TextSpan(text: "${LocaleKeys.comment.tr()} ", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 15),
              child: Text(
                "${way_item["comment"]}",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.3,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 20),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: 19,
                          height: 1.7,
                          color: Colors.black
                      ),
                      children: [
                        TextSpan(text: "${LocaleKeys.contact.tr()}\n", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "\t\t${LocaleKeys.name.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "${way_item["name"]}\n"),
                        TextSpan(text: "\t\t${LocaleKeys.Phone.tr()}: ", style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "${way_item["tel"]}\n"),
                      ]
                  )
              ),
            ),
          ],
        ),
      ),
    );

  }
}
