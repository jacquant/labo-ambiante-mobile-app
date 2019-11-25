import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ambiante_mobile/pages/namur_map.dart';

import '../widgets/drawer.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';

  // /!\ OUTSIDE OF "build" TO MAKE IT WORK WITH IOS (probablmy linked with the fact that changing android to is is reloading everything ?...)
  // The MapController gives us the current center position (LatLng)
  // and allows us to move and zoom on the map (_mapctl.move()).
  final MapController _mapctl = MapController();

  @override
  Widget build(BuildContext context) {

    final map = NamurMap(_mapctl);

    return Scaffold(
      appBar: AppBar(title: Text('Carte des évènements')),
      drawer: buildDrawer(context, route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                  'Ambiante et mobile Project Map'),
            ),
            Flexible(
              child: map,
            ),
          ],
        ),
      ),
    );
  }
}
