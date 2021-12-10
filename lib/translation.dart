import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import '../translations/locale_keys.g.dart';
class Translation extends StatelessWidget {
  const Translation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translation"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Column(
            children: [
              Text(LocaleKeys.home_screen_Transport_services.tr(),
              style: TextStyle(
                fontSize: 25
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async
                    {
                      await context.setLocale(Locale('en'));
                    },
                    child: Text('English'),
                  ),
                  ElevatedButton(
                    onPressed: () async
                    {
                      await context.setLocale(Locale('ru'));
                    },
                    child: Text('Russian'),
                  ),
                  ElevatedButton(
                    onPressed: () async
                    {
                      await context.setLocale(Locale('uz'));
                    },
                    child: Text('Uzbek'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
