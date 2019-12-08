
import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/filters.dart';
import '../pages/tap_to_add.dart';
import '../pages/legend.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Center(
            child: Text('Ambiante et mobile App'),
          ),
        ),
        ListTile(
          title: const Text('Ajouter un évènement'),
          selected: currentRoute == TapToAddPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, TapToAddPage.route);
          },
        ),
        ListTile(
          title: const Text('Carte des évènements'),
          selected: currentRoute == HomePage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, HomePage.route);
          },
        ),
        ListTile(
          title: const Text("Choisir mes types d'évènements"),
          selected: currentRoute == FiltersPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, FiltersPage.route);
          },
        ),
        ListTile(
          title: const Text("Voir la légende"),
          selected: currentRoute == LegendPage.route,
          onTap: () {
            Navigator.pushReplacementNamed(context, LegendPage.route);
          },
        ),
      ],
    ),
  );
}
