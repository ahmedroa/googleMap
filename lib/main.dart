import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mappp/screen/DistanceCalculation.dart';
import 'package:mappp/screen/OrderDetails.dart';
import 'package:mappp/screen/Screens/home.dart';
import 'package:mappp/screen/geocoding.dart';
import 'package:mappp/screen/geolocator.dart';
import 'package:mappp/screen/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // themeMode: ThemeMode.dark,
      // darkTheme: ThemeData.dark(),
      // localizationsDelegates: [
      //   GlobalCupertinoLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [Locale("ar", "AE")],
      // locale: Locale("ar", "AE"),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homeS(),
    );
  }
}
