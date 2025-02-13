import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:ambiante_mobile/main.dart';
import 'package:http/http.dart' as http;

Future<Map> fetchEvents() async {

  //print("-------------------------");
  //print(globalCity);
  //print(globalCat);
  //print(globalSound);

  var init = false;

  var category = globalCat;

  var city = globalCity;

  var soundLevelMax = globalSound;

  var startTimeMax = globalMaxDate;

  var startTimeMin = globalMinDate;

  var query = 'http://vps747217.ovh.net:8181/events?';

  if (category.length > 0){

    init = true;

    query += 'category=';

    for (var i in category) {
      query += i+',';
    }
    query = query.substring(0, query.length - 1);

  }

  if (city.length > 0){

    if (init){
      query += '&city=';
    }
    else{
      query += 'city=';
      init = true;
    }
    

    for (var i in city) {
      query += i+',';
    }
    query = query.substring(0, query.length - 1);

  }

  if (soundLevelMax.length > 0){

    if (init){
      query += '&sound_level_max=';
    }
    else{
      query += 'sound_level_max=';
      init = true;
    }

    for (var i in soundLevelMax) {
      query += i+',';
    }
    query = query.substring(0, query.length - 1);

  }

  if (startTimeMax.length > 0){

    if (init){
      query += '&start_time_max=';
    }
    else{
      query += 'start_time_max=';
      init = true;
    }

    for (var i in startTimeMax) {
      query += i+',';
    }
    query = query.substring(0, query.length - 1);

  }

  if (startTimeMin.length > 0){

    if (init){
      query += '&start_time_min=';
    }
    else{
      query += 'start_time_min=';
      init = true;
    }

    for (var i in startTimeMin) {
      query += i+',';
    }
    query = query.substring(0, query.length - 1);

  }

  if (startTimeMin.length == 0){

    if (init){
      query += '&start_time_min=';
    }
    else{
      query += 'start_time_min=';
      init = true;
    }

    var now = new DateTime.now();
    var currentDate = new DateFormat("yyyy-MM-dd").format(now)+"T00:00:00";

    query += currentDate;
  }

  print(query);
  
  final response = await http.get(query);
  String body = utf8.decode(response.bodyBytes);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return json.decode(body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

makePostRequest(
    String id,
    String title,
    String organizers,
    String startTime,
    String endTime,
    String description,
    String category,
    String zipCode,
    String city,
    String street,
    String streetNumber,
    String phone,
    String mail,
    String website,
    double lat,
    double lon,
    String source,
    int soundLevel) async {
  // set up POST request arguments
  
  String url = 'http://vps747217.ovh.net:8181/events';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"id": "'+id+'",' + '"title": "'+title+'",' + '"organizers": "'+organizers+'",' + '"start_time": "'+startTime+'",' + '"end_time": "'+endTime+'",' + '"description": "'+description+'",' + '"category": "'+category+'",' + '"zip_code": "'+zipCode+'",' + '"city": "'+city+'",' + '"street": "'+street+'",' + '"street_number": "'+streetNumber+'",' + '"phone": "'+phone+'",' + '"mail": "'+mail+'",' + '"website": "'+website+'", "lat": '+lat.toString() + ',  "lon": '+lon.toString()+', '+  '"source": "'+source+'",  "sound_level":' + soundLevel.toString() +'}';
  //print(json);
  // make POST request
  http.Response response = await http.post(url, headers: headers, body: json);
  // check the status code for the result
  int statusCode = response.statusCode;
  print("status is : " + statusCode.toString());
  // this API passes back the id of the new item added to the body
  String body = response.body;
  print(body);
  // {
  //   "title": "Hello",
  //   "body": "body text",
  //   "userId": 1,
  //   "id": 101
  // }
}
