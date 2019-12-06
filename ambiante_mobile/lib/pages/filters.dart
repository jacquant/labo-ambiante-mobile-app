// Create a Form widget.
import 'package:ambiante_mobile/main.dart';
import 'package:ambiante_mobile/pages/home.dart';
import 'package:flutter/material.dart';

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
    TextEditingController soundController = new TextEditingController();

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
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.visibility),
                  hintText: "Rock, Country, Bibitive *",
                  labelText: "Quels types d'évènements vous intéressent ?",
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              TextFormField(
                controller: soundController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.surround_sound),
                  hintText: '80.0 *',
                  labelText: 'Niveau décibels maximum ?',
                ),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String value) {
                  return value.contains('@') ? 'Do not use the @ char.' : null;
                },
              ),
              FlatButton(
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  'Rafraichir',
                ),
                onPressed: () {
                  if (cityController.value.text.isNotEmpty) {
                    global_city.add(cityController.value.text);
                  }

                  if (categoryController.value.text.isNotEmpty) {
                    global_cat.add(categoryController.value.text);
                  }

                  if (soundController.value.text.isNotEmpty) {
                    global_sound.add(soundController.value.text);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Text(
                  'Remettre les filtres à zéro !',
                ),
                onPressed: () {
                  global_city = [];
                  global_cat = [];
                  global_sound = [];
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
