import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ambiante_mobile/data/load_events.dart';
import 'package:latlong/latlong.dart';

import 'launch_google_map.dart';

class NamurMap extends StatefulWidget {
  final _NamurMapState state = _NamurMapState();
  final MapController controller;

  @override
  _NamurMapState createState() {
    return state;
  }

  // Constructor
  NamurMap(this.controller);
}

class _NamurMapState extends State<NamurMap> {
  // List of markers given in a JSON file.
  List<Marker> markers = [];

  LatLng centerValue = LatLng(56.73173, 11.533808);

  double zoomValue = 13.0;

  // Fill the markers list with events from the JSON.
  void loadMarkers() async {
    var dataJson = await fetchEvents();

    setState(() {
      // re-initialize the list of markers
      markers = [];

      for (var event in dataJson['events']) {
        String eventName = event['title'];
        var coordXY = LatLng(event['lat'], event['lon']);
        var typeEvent = event['category'];
        var source = event['source'];
        var soundLevel = event['sound_level'];

        var description = event['description'];
        var startTime = event['start_time'];
        var endTime = event['end_time'];
        var numStreet = event['street_number'];
        var streetName = event['street'];
        var website = event['website'];
        markers.add(createMarker(
            eventName,
            coordXY,
            typeEvent,
            source,
            soundLevel,
            description,
            startTime,
            endTime,
            numStreet,
            streetName,
            website));
      }
    });
  }

  // This fct creates a Marker and place it on the coordinate XY
  Marker createMarker(
      String id,
      LatLng coordXY,
      String typeEvent,
      String source,
      double soundLevel,
      String description,
      String startTime,
      String endTime,
      String numStreet,
      String streetName,
      String website) {
    var info = _infoEvent(id, coordXY, typeEvent, source, soundLevel,
        description, startTime, endTime, numStreet, streetName, website);

    Map listIcons = {
      'foire': Icon(Icons.supervised_user_circle),
      'exposition': Icon(Icons.panorama_horizontal),
      'conference': Icon(Icons.record_voice_over),
      'cinema': Icon(Icons.theaters),
      'sport': Icon(Icons.visibility),
      'concert': Icon(Icons.music_note),
      'visite': Icon(Icons.tag_faces),
      'spectacle': Icon(Icons.child_care),
      'unknown': Icon(Icons.cloud),
    };

    var eventIcon = listIcons['unknown'];
    if (listIcons.containsKey(typeEvent)) {
      eventIcon = listIcons[typeEvent];
    }

    var eventColor = Colors.red;
    if (source == 'namur-agenda-des-evenements') {
      eventColor = Colors.blue;
    }

    var eventIconSize = 5*(soundLevel/10);
    if (eventIconSize >= 50.0) {
      eventIconSize = 50.0;
    }

    if (eventIconSize < 18.0) {
      eventIconSize = 18.0;
    }

    var marker = Marker(
      width: eventIconSize + (10.0),
      height: eventIconSize + (10.0),
      point: coordXY,
      builder: (context) => Container(
        //color: Colors.green,
        alignment: Alignment.topRight,
        child: IconButton(
          icon: eventIcon,
          color: eventColor,
          iconSize: eventIconSize,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (builder) {
                return Container(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    children: info,
                  ),
                );
              },
            );
          },
        ),
      ),
    );

    return marker;
  }

  List<Widget> _infoEvent(
      String id,
      LatLng coordXY,
      String typeEvent,
      String source,
      double soundLevel,
      String description,
      String startTime,
      String endTime,
      String numStreet,
      String streetName,
      String website) {
    List<Widget> textWidgets = [];

    textWidgets.add(
      Text(
        id,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Catégorie :' + typeEvent,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Source :' + source,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Description :' + description.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Niveau de décibels :' + soundLevel.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Début :' + startTime.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Fin :' + endTime.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Numéro de la rue :' + numStreet.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Nom de la rue :' + streetName.toString(),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        'Site web :' + website.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );

    textWidgets.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 5),
        child: FlatButton(
          color: Colors.blue,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
            "Voir l'itinéraire",
          ),
          onPressed: () {
            MapUtils.openMap(coordXY.latitude, coordXY.longitude);
          },
        ),
      ),
    );

    return textWidgets;
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.controller,
      options: MapOptions(
        center: LatLng(50.464281, 4.860729),
        minZoom: 10.0,
        zoom: 15.0,
        swPanBoundary: LatLng(50.420524, 4.771015),
        nePanBoundary: LatLng(50.548536, 5.092013),
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiamFjcXVhbnQiLCJhIjoiY2syeHFpemxqMDAxYzNsbXFrcWwwOGxmbyJ9.F94lOloBRxltcsySUlvwGA',
            'id': 'mapbox.streets',
          },
            tileProvider: NonCachingNetworkTileProvider()
        ),
        MarkerLayerOptions(markers: markers),
      ],
    );
  }
}
