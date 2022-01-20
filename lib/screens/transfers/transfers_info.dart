import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/translations/locale_keys.g.dart';


class TransfersInfo extends StatelessWidget {
  Map<String, dynamic> info;

  TransfersInfo(@required this.info);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${LocaleKeys.application.tr()} #${info['id']}",
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
              padding: EdgeInsets.only(top: 12),
              height: info["places"].length * 170.0,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: info["places"].length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 8),
                        child: Text(
                          '${info["places"][index]['type'] == "meeting" ? LocaleKeys.meeting.tr() : LocaleKeys.Drop_of.tr()}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange
                          ),),

                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 24, top: 6),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontSize: 17
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${info["places"][index]['city']} ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(text: '( ${info["places"][index]['date'].substring(0, 10)} '),
                              TextSpan(text: '${info["places"][index]['time']})\n'),
                              TextSpan(
                                  text: '${LocaleKeys.Passengers.tr()}: ',
                                  style: TextStyle(fontWeight: FontWeight.bold,)
                              ),
                              TextSpan(text: '${info["places"][index]['passengers']}\n'),
                              TextSpan(
                                  text: '${LocaleKeys.Where_to_pick_up.tr()}: ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(text: '${info["places"][index]['from']}\n'),
                              TextSpan(
                                  text: '${LocaleKeys.where.tr()}: ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(
                                  text: '${info["places"][index]['to']}\n'
                              ),
                              TextSpan(
                                  text: '${LocaleKeys.note.tr()}: ',
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              TextSpan(
                                  text: '${info["places"][index]['additional']}'
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            if(info['car_type'] != null) Padding(
              padding: EdgeInsets.only(left: 16,top: 16),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),
                    children: [
                      TextSpan(
                          text: '${LocaleKeys.Auto_types.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['car']}\n'),
                      TextSpan(
                          text: 'Auto: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['car_type']["name"]}\n'),
                      TextSpan(
                          text: '${LocaleKeys.status.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w500)
                      ),
                      TextSpan(text: '${info['status']}')
                    ]
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16,top: 24),
                child: Text(
                  LocaleKeys.contact.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: 24,top: 8),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),
                    children: [
                      TextSpan(
                          text: 'E-mail: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_email']}\n'),
                      TextSpan(
                          text: '${LocaleKeys.phone.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_phone']}\n'),
                      TextSpan(
                          text: '${LocaleKeys.name.tr()}: ',
                          style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      TextSpan(text: '${info['user_name']}')
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
