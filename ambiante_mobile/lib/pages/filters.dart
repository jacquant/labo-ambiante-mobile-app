// Create a Form widget.
import 'package:ambiante_mobile/main.dart';
import 'package:ambiante_mobile/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';

import '../widgets/drawer.dart';

class FiltersPage extends StatefulWidget {
  static const String route = '/filter';

  @override
  FiltersPageState createState() {
    return FiltersPageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class FiltersPageState extends State<FiltersPage> {
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
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController cityController = new TextEditingController();
    TextEditingController categoryController = new TextEditingController();
    TextEditingController maxDateController = new TextEditingController();
    TextEditingController minDateController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Définissez votre propre filtre !")),
      drawer: buildDrawer(context, FiltersPage.route),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text("Voici une liste de filtres"),
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.location_city),
                  hintText: 'Quelle ville visitez-vous ?',
                  labelText: 'Namur *',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              DropDownField(
                  controller: categoryController,
                  value: eventType,
                  required: true,
                  strict: true,
                  hintText: "Quels types d'évènements vous intéressent ?",
                  labelText: 'artistique *',
                  icon: Icon(Icons.visibility),
                  items: typesOfEvents,
                  setter: (dynamic newValue) {
                    eventType = newValue;
                  }),
              SliderInFilter(),
              DateTimePickerFormField(
                controller: maxDateController,
                inputType: InputType.both,
                format: DateFormat("yyyy-MM-ddThh:mm:ss"),
                editable: false,
                decoration: InputDecoration(
                    icon: Icon(Icons.time_to_leave),
                    labelText: "Date maximale d'affichage",
                    hasFloatingPlaceholder: false),
                onChanged: (dt2) {
                  DateTime date2;
                  setState(() => date2 = dt2);
                  print('Selected date: $date2');
                },
              ),
              DateTimePickerFormField(
                autofocus: false,
                controller: minDateController,
                inputType: InputType.both,
                format: DateFormat("yyyy-MM-ddThh:mm:ss"),
                editable: false,
                decoration: InputDecoration(
                    icon: Icon(Icons.time_to_leave),
                    labelText: "Date minimale d'affichage",
                    hasFloatingPlaceholder: false),
                onChanged: (dt2) {
                  DateTime date2;
                  setState(() => date2 = dt2);
                  print('Selected date: $date2');
                },
              ),
              FlatButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  'Actualiser',
                ),
                onPressed: () {
                  if (cityController.text.isNotEmpty) {
                    globalCity.add(cityController.text);
                  }

                  if (categoryController.text.isNotEmpty) {
                    globalCat.add(categoryController.text);
                  }

                  if (soundIntensityFilter != null) {
                    globalSound = [soundIntensityFilter.toString()];
                  }

                  if (maxDateController.text.isNotEmpty) {
                    globalMaxDate = [maxDateController.text];
                  }

                  if (minDateController.text.isNotEmpty) {
                    globalMinDate = [minDateController.text];
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              BetterFilterShow(),
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  'Remettre tous les filtres à zéro !',
                ),
                onPressed: () {
                  globalCity = [];
                  globalCat = [];
                  globalSound = [];
                  globalMaxDate = [];
                  globalMinDate = [];
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ],
          )),
    );
  }
}

class BetterFilterShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _BetterFilterShowState();
  }
}

class _BetterFilterShowState extends State<BetterFilterShow> {
  //List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: 50,
                    height: 25,
                    child: FlatButton(
                      splashColor: Colors.red,
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        'X',
                      ),
                      onPressed: () {
                        globalCity = [];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FiltersPage()),
                        );
                      },
                    )),
                Text(" Filtres actuels (Ville): "),
              ],
            ),
            Text(
              globalCity.toString(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: 50,
                    height: 25,
                    child: FlatButton(
                      splashColor: Colors.red,
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text(
                        'X',
                      ),
                      onPressed: () {
                        globalCat = [];

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FiltersPage()),
                        );
                      },
                    )),
                Text(" Filtres actuels (Catégorie): "),
              ],
            ),
            Text(
              globalCat.toString(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 25,
                  child: FlatButton(
                    splashColor: Colors.red,
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      'X',
                    ),
                    onPressed: () {
                      globalSound = [];

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FiltersPage()),
                      );
                    },
                  ),
                ),
                Text(" Filtres actuels (Décibel): "),
              ],
            ),
            Text(
              globalSound.toString(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 25,
                  child: FlatButton(
                    splashColor: Colors.red,
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      'X',
                    ),
                    onPressed: () {
                      globalMaxDate = [];

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FiltersPage()),
                      );
                    },
                  ),
                ),
                Text(" Filtres actuels (Date maximale): "),
              ],
            ),
            Text(
              globalMaxDate.toString(),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 25,
                  child: FlatButton(
                    splashColor: Colors.red,
                    color: Colors.red,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Text(
                      'X',
                    ),
                    onPressed: () {
                      globalMinDate = [];

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FiltersPage()),
                      );
                    },
                  ),
                ),
                Text(" Filtres actuels (Date minimale): "),
              ],
            ),
            Text(
              globalMinDate.toString(),
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}

int soundIntensityFilter = 140;

class SliderInFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SliderInFilterState();
  }
}

class _SliderInFilterState extends State<SliderInFilter> {
  //List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          height: 50,
          child:
              Center(child: Text("Niveau de décibels max de votre évènement"))),
      Slider(
        value: soundIntensityFilter.toDouble(),
        min: 0.0,
        max: 140.0,
        divisions: 10,
        activeColor: Colors.red,
        inactiveColor: Colors.black,
        label: getLabel(soundIntensityFilter),
        onChanged: (double newValue) {
          setState(() {
            soundIntensityFilter = newValue.round();
          });
        },
      ),
    ]);
  }
}

getLabel(soundIntensityFilter) {
  if (soundIntensityFilter <= 0) {
    return soundIntensityFilter.toString() + " Db - Le vide interstellaire";
  }
  if (soundIntensityFilter > 0 && soundIntensityFilter <= 10.0) {
    return soundIntensityFilter.toString() + " Db - Le bruit d'une respiration";
  }
  if (soundIntensityFilter > 10 && soundIntensityFilter <= 20.0) {
    return soundIntensityFilter.toString() + ' Db - le bruit du vents';
  }
  if (soundIntensityFilter > 20 && soundIntensityFilter <= 30.0) {
    return soundIntensityFilter.toString() + ' Db - Les gens chuchottent';
  }
  if (soundIntensityFilter > 30 && soundIntensityFilter <= 40.0) {
    return soundIntensityFilter.toString() + " Db - Le bruit d'un frigo";
  }
  if (soundIntensityFilter > 40 && soundIntensityFilter <= 50.0) {
    return soundIntensityFilter.toString() + ' Db - Le son de la pluie';
  }
  if (soundIntensityFilter > 50 && soundIntensityFilter <= 60.0) {
    return soundIntensityFilter.toString() + ' Db - Des gens discutent';
  }
  if (soundIntensityFilter > 60 && soundIntensityFilter <= 70.0) {
    return soundIntensityFilter.toString() + " Db - Le bruit d'une voiture";
  }
  if (soundIntensityFilter > 70 && soundIntensityFilter <= 80.0) {
    return soundIntensityFilter.toString() + " Db - Le son d'un camion";
  }
  if (soundIntensityFilter > 80 && soundIntensityFilter <= 90.0) {
    return soundIntensityFilter.toString() +
        " Db - Le bruit d'un sèche cheveux";
  }
  if (soundIntensityFilter > 90 && soundIntensityFilter <= 100.0) {
    return soundIntensityFilter.toString() + " Db - Le son d'un hélicoptère";
  }
  if (soundIntensityFilter > 100 && soundIntensityFilter <= 110.0) {
    return soundIntensityFilter.toString() + " Db - Le son d'une trompette";
  }
  if (soundIntensityFilter > 110 && soundIntensityFilter <= 120.0) {
    return soundIntensityFilter.toString() +
        " Db - Le bruit d'une sirène de police";
  }
  if (soundIntensityFilter > 120 && soundIntensityFilter <= 130.0) {
    return soundIntensityFilter.toString() + " Db - Le vacarme d'un avion";
  }
  if (soundIntensityFilter > 130 && soundIntensityFilter <= 140.0) {
    return soundIntensityFilter.toString() +
        " Db - L'explosion de feux d'artifice";
  }
}
