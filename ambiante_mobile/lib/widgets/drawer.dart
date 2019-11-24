import 'package:flutter/material.dart';

import '../pages/home.dart';

import '../pages/tap_to_add.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Center(
            child: Text('Flutter Map Examples'),
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
      ],
    ),
  );
}
