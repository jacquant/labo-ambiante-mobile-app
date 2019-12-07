
import 'package:flutter/material.dart';

import './pages/home.dart';
import './pages/tap_to_add.dart';
import './pages/filters.dart';
import './pages/legend.dart';

void main() => runApp(MyApp());

List<String> global_city = [];
List<String> global_cat = [];
List<String> global_sound = [];

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map Example',
      theme: ThemeData(
        primarySwatch: mapBoxBlue,
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
const int _bluePrimary = 0xFF395afa;
const MaterialColor mapBoxBlue = MaterialColor(
  _bluePrimary,
  <int, Color>{
    50: Color(0xFFE7EBFE),
    100: Color(0xFFC4CEFE),
    200: Color(0xFF9CADFD),
    300: Color(0xFF748CFC),
    400: Color(0xFF5773FB),
    500: Color(_bluePrimary),
    600: Color(0xFF3352F9),
    700: Color(0xFF2C48F9),
    800: Color(0xFF243FF8),
    900: Color(0xFF172EF6),
  },
);
