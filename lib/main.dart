import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/splash/splash_screen.dart';
import 'package:travelcars/translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
          supportedLocales: [
            Locale('en'),
            Locale('ru'),
            Locale('uz'),
          ],
          path:'assets/translations',
          fallbackLocale: Locale('en', 'US'),
          assetLoader: CodegenLoader(),
          child: MyApp())
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TravelCars',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreen(),
    );
  }
}