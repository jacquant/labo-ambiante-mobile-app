import 'package:ambiante_mobile/data/load_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdownfield/dropdownfield.dart';

import '../pages/home.dart';

import '../widgets/drawer.dart';

int soundIntensity = 0;

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
    TextEditingController categoryController = new TextEditingController();
    TextEditingController startTimeController = new TextEditingController();
    TextEditingController endTimeController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    TextEditingController websiteController = new TextEditingController();
    TextEditingController streetController = new TextEditingController();
    TextEditingController streetNumberController = new TextEditingController();

    var eventType;

    List<String> typesOfEvents = [
      'foire',
      'exposition',
      'conference',
      'cinema',
      'sport',
      'concert',
      'visite',
      'spectacle',
      'unknown',
    ];

    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 40.0,
        height: 40.0,
        point: latlng,
        builder: (ctx) => Container(
          child: IconButton(
            icon: Icon(Icons.add_location),
            color: Colors.deepPurple,
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
                                DropDownField(
                                    controller: categoryController,
                                    value: eventType,
                                    required: true,
                                    strict: true,
                                    hintText: "Quel est le type d'évènement",
                                    labelText: 'artistique *',
                                    icon: Icon(Icons.party_mode),
                                    items: typesOfEvents,
                                    setter: (dynamic newValue) {
                                      eventType = newValue;
                                    }),
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
                                DateTimePickerFormField(
                                  controller: startTimeController,
                                  inputType: InputType.both,
                                  format: DateFormat("yyyy-MM-ddThh:mm:ss"),
                                  editable: false,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.timer),
                                      hintText: "Date du début de l'évènement",
                                      labelText: "Début de l'évènement",
                                      hasFloatingPlaceholder: false),
                                  onChanged: (dt) {
                                    DateTime date1;
                                    setState(() => date1 = dt);
                                    print('Selected date: $date1');
                                  },
                                ),
                                DateTimePickerFormField(
                                  controller: endTimeController,
                                  inputType: InputType.both,
                                  format: DateFormat("yyyy-MM-ddThh:mm:ss"),
                                  editable: false,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.time_to_leave),
                                      hintText: "Date de la fin de l'évènement",
                                      labelText: "Fin de l'évènement",
                                      hasFloatingPlaceholder: false),
                                  onChanged: (dt2) {
                                    DateTime date2;
                                    setState(() => date2 = dt2);
                                    print('Selected date: $date2');
                                  },
                                ),
                                TextFormField(
                                  controller: streetController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.streetview),
                                    hintText: 'rue Jean Colin',
                                    labelText:
                                        "Entrez la rue où votre évènement se déroulera",
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
                                  controller: streetNumberController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.confirmation_number),
                                    hintText: '16',
                                    labelText: "Entrez le numéro du batiment",
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
                                  controller: websiteController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.web),
                                    hintText: 'www.MonSiteWeb.com',
                                    labelText: "Entrez l'url de votre site",
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
                                SliderInNavigationBar(),
                                RaisedButton(
                                  child: Text('Valider'),
                                  onPressed: () {
                                    
                                    if (tappedPoints.length == 1) {
                                      var id = uuid.v1();
                                      var source = "A user";
                                      var organizers = "A user";
                                      var mail = "user-mail.com";
                                      var phone = "000-000-000";
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
                                          streetController.text,
                                          streetNumberController.text,
                                          phone,
                                          mail,
                                          websiteController.text,
                                          tappedPoints[0].latitude,
                                          tappedPoints[0].longitude,
                                          source,
                                          soundIntensity);
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

class SliderInNavigationBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SliderInNavigationBarScreenState();
  }
}

class _SliderInNavigationBarScreenState extends State<SliderInNavigationBar> {
  //List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: 50,
          child:
              Center(child: Text("Niveau de décibels max de votre évènement"))),
      Slider(
        value: soundIntensity.toDouble(),
        min: 0.0,
        max: 140.0,
        divisions: 10,
        activeColor: Colors.red,
        inactiveColor: Colors.black,
        label: getLabel(soundIntensity),
        onChanged: (double newValue) {
          setState(() {
            soundIntensity = newValue.round();
          });
        },
      ),
    ]);
  }
}

getLabel(soundIntensity) {
  if (soundIntensity <= 0) {
    return "Le vide interstellaire";
  }
  if (soundIntensity > 0 && soundIntensity <= 10.0) {
    return soundIntensity.toString() + " Db - Le bruit d'une respiration";
  }
  if (soundIntensity > 10 && soundIntensity <= 20.0) {
    return soundIntensity.toString() + " Db - le bruit du vents";
  }
  if (soundIntensity > 20 && soundIntensity <= 30.0) {
    return soundIntensity.toString() + " Db - Les gens chuchottent";
  }
  if (soundIntensity > 30 && soundIntensity <= 40.0) {
    return soundIntensity.toString() + " Db - Le bruit d'un frigo";
  }
  if (soundIntensity > 40 && soundIntensity <= 50.0) {
    return soundIntensity.toString() + " Db - Le son de la pluie";
  }
  if (soundIntensity > 50 && soundIntensity <= 60.0) {
    return soundIntensity.toString() + " Db - Des gens discutent";
  }
  if (soundIntensity > 60 && soundIntensity <= 70.0) {
    return soundIntensity.toString() + " Db - Le bruit d'une voiture";
  }
  if (soundIntensity > 70 && soundIntensity <= 80.0) {
    return soundIntensity.toString() + " Db - Le son d'un camion";
  }
  if (soundIntensity > 80 && soundIntensity <= 90.0) {
    return soundIntensity.toString() + " Db - Le bruit d'un sèche cheveux";
  }
  if (soundIntensity > 90 && soundIntensity <= 100.0) {
    return soundIntensity.toString() + " Db - Le son d'un hélicoptère";
  }
  if (soundIntensity > 100 && soundIntensity <= 110.0) {
    return soundIntensity.toString() + " Db - Le son d'une trompette";
  }
  if (soundIntensity > 110 && soundIntensity <= 120.0) {
    return soundIntensity.toString() + " Db - Le bruit d'une sirène de police";
  }
  if (soundIntensity > 120 && soundIntensity <= 130.0) {
    return soundIntensity.toString() + " Db - Le vacarme d'un avion";
  }
  if (soundIntensity > 130 && soundIntensity <= 140.0) {
    return soundIntensity.toString() + " Db - L'explosion de feux d'artifice";
  }
}
