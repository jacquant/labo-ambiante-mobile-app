
import 'package:flutter/material.dart';

import './pages/home.dart';
import './pages/tap_to_add.dart';
import './pages/filters.dart';
import './pages/legend.dart';

void main() => runApp(MyApp());

List<String> globalCity = [];
List<String> globalCat = [];
List<String> globalSound = [];
List<String> globalMaxDate = [];
List<String> globalMinDate = [];

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ambiante et mobile app',
      theme: ThemeData(
        primarySwatch: mapBoxPurple,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        TapToAddPage.route: (context) => TapToAddPage(),
        FiltersPage.route: (context) => FiltersPage(),
        LegendPage.route: (context) => LegendPage(),
      },
    );
  }
}

// Generated using Material Design Palette/Theme Generator
// http://mcg.mbitson.com/
// https://github.com/mbitson/mcg
const int _purplePrimary = 0xFF9C27B0;
const MaterialColor mapBoxPurple = MaterialColor(
  _purplePrimary,
  <int, Color>{
    50: Color(0xFFF3E5F5),
    100: Color(0xFFE1BEE7),
    200: Color(0xFFCE93D8),
    300: Color(0xFFBA68C8),
    400: Color(0xFFAB47BC),
    500: Color(_purplePrimary),
    600: Color(0xFF8E24AA),
    700: Color(0xFF7B1FA2),
    800: Color(0xFF6A1B9A),
    900: Color(0xFF4A148C),
  },
);
