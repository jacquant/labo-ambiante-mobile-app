import 'package:ambiante_mobile/data/load_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:uuid/uuid.dart';
import 'package:mdi/mdi.dart';

import '../pages/home.dart';

import '../widgets/drawer.dart';

class TapToAddPage extends StatefulWidget {
  static const String route = '/tap';

  @override
  State<StatefulWidget> createState() {
    return TapToAddPageState();
  }
}

class TapToAddPageState extends State<TapToAddPage> {
  var uuid = Uuid();

  List<LatLng> tappedPoints = [];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    TextEditingController titleController = new TextEditingController();
    TextEditingController startTimeController = new TextEditingController();
    TextEditingController endTimeController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    TextEditingController categoryController = new TextEditingController();

    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 40.0,
        height: 40.0,
        point: latlng,
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(Icons.add_location),
            color: Colors.blue,
            iconSize: 45.0,
            onPressed: () {
              print('Marker tapped');
            },
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Ajout d'un évènement")),
      drawer: buildDrawer(context, TapToAddPage.route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child:
                  Text("cliquer à l'endroit où vous voulez créer l'évènement"),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(50.464281, 4.860729),
                    minZoom: 10.0,
                    zoom: 15.0,
                    swPanBoundary: LatLng(50.420524, 4.771015),
                    nePanBoundary: LatLng(50.548536, 5.092013),
                    onTap: _handleTap),
                layers: [
                  TileLayerOptions(
                    urlTemplate: "https://api.tiles.mapbox.com/v4/"
                        "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoiamFjcXVhbnQiLCJhIjoiY2syeHFpemxqMDAxYzNsbXFrcWwwOGxmbyJ9.F94lOloBRxltcsySUlvwGA',
                      'id': 'mapbox.streets',
                    },
                  ),
                  MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
            FlatButton(
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Text(
                'Valider',
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Scaffold(
                        key: _formKey,
                        appBar:
                            AppBar(title: Text("Définissez votre évènement !")),
                        body: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListView(
                              padding: const EdgeInsets.all(8),
                              children: <Widget>[
                                TextFormField(
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: 'Donnez vie à votre évènement',
                                    labelText: 'MonEvènement *',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  validator: (String value) {
                                    return value.contains('@')
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },
                                ),
                                TextFormField(
                                  controller: categoryController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.party_mode),
                                    hintText: "Quel est le type d'évènement",
                                    labelText: 'Rock, Metal, Artistique *',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  validator: (String value) {
                                    return value.contains('@')
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },
                                ),
                                TextFormField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.book),
                                    hintText: "Ajoutez une description ",
                                    labelText: '... *',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  validator: (String value) {
                                    return value.contains('@')
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },
                                ),
                                TextFormField(
                                  controller: startTimeController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: 'Donnez une heure de rendez-vous',
                                    labelText: '18h00-22h00 *',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  validator: (String value) {
                                    return value.contains('@')
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },
                                ),
                                TextFormField(
                                  controller: endTimeController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: "Fin de l'évènement",
                                    labelText: '18h00-22h00 *',
                                  ),
                                  onSaved: (String value) {
                                    // This optional block of code can be used to run
                                    // code when the user saves the form.
                                  },
                                  validator: (String value) {
                                    return value.contains('@')
                                        ? 'Do not use the @ char.'
                                        : null;
                                  },
                                ),
                                RaisedButton(
                                  child: Text('Valider'),
                                  onPressed: () {
                                    if (tappedPoints.length == 1) {
                                      var id = uuid.v1();
                                      var source = "A user";
                                      var organizers = "A user";
                                      var soundLevel = 5;
                                      var website = "";
                                      var mail = "user-mail.com";
                                      var phone = "000-000-000";
                                      var streetNumber = "";
                                      var street = "";
                                      var city = "Namur";
                                      var zipCode = "5000";
                                    

                                      makePostRequest(
                                          id,
                                          titleController.text,
                                          organizers,
                                          startTimeController.text,
                                          endTimeController.text,
                                          descriptionController.text,
                                          categoryController.text,
                                          zipCode,
                                          city,
                                          street,
                                          streetNumber,
                                          phone,
                                          mail,
                                          website,
                                          tappedPoints[0].latitude,
                                          tappedPoints[0].longitude,
                                          source,
                                          soundLevel);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                      // _formKey.currentState.save();
                                    }
                                  },
                                ),
                              ],
                            )),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(LatLng latlng) {
    setState(() {
      tappedPoints = [latlng];
    });
  }
}


