
import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;


Future<String> _loadLocauxAsset() async {
  // Location of the json file here.
  return await rootBundle.loadString('assets/map/events.json');
}

Future <Map> loadLocaux() async {

  var jsonLocaux = await _loadLocauxAsset();

  final Map jsonMap = jsonDecode(jsonLocaux);

  return jsonMap;
}
