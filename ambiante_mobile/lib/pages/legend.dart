import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class LegendPage extends StatelessWidget {
  static const String route = '/legend';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Légende')),
      drawer: buildDrawer(context, route),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  color: Colors.blue,
                ),
                Text(" - Evèvenements officiels de la ville de Namur."),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  color: Colors.red,
                ),
                Text(" - Evèvenements provenants de boitiers connectés."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.record_voice_over),
                Text(" - conférence."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.theaters),
                Text(" - cinéma."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.music_note),
                Text(" - concert."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.panorama_horizontal),
                Text(" - exposition."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.supervised_user_circle),
                Text(" - foire."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.music_note),
                Text(" - concert."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.child_care),
                Text(" - spectacle."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.music_note),
                Text(" - sport."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.cloud),
                Text(" - unknown."),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(Icons.tag_faces),
                Text(" - visite."),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
