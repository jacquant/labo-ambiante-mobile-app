import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ambiante_mobile/data/load_events.dart';
import 'package:latlong/latlong.dart';
import 'package:mdi/mdi.dart';

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
        markers.add(
            createMarker(eventName, coordXY, typeEvent, source, soundLevel));
      }
    });
  }

  // This fct creates a Marker and place it on the coordinate XY
  Marker createMarker(String id, LatLng coordXY, String typeEvent,
      String source, double soundLevel) {
    var info = _infoEvent(id, coordXY, typeEvent, source, soundLevel);

    Map listIcons = {
      '': Icon(Icons.healing),
      'Metal': Icon(Icons.healing),
      'string': Icon(Icons.healing),
      'sport': Icon(Icons.visibility),
      'exposition': Icon(Icons.panorama_horizontal),
      'concert': Icon(Icons.music_note),
      'spectacle': Icon(Icons.child_care),
      'conference': Icon(Icons.record_voice_over),
      'foire': Icon(Icons.supervised_user_circle),
      'cinema': Icon(Icons.theaters),
      'visite': Icon(Icons.tag_faces),
      'activite': Icon(Mdi.train)
    };
    var eventIcon = listIcons[typeEvent];
    var eventColor = Colors.red;
    if (source == 'namur-agenda-des-evenements') {
      eventColor = Colors.blue;
    }

    var eventIconSize = 15.0 + (soundLevel * 5.0);

    var marker = Marker(
      width: 35.0,
      height: 35.0,
      point: coordXY,
      builder: (context) => Container(
        color: Colors.green,
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

  List<Widget> _infoEvent(String id, LatLng coordXY, String typeEvent,
      String source, double soundLevel) {
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
        typeEvent,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        source,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
    );

    textWidgets.add(
      Text(
        soundLevel.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
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
        ),
        MarkerLayerOptions(markers: markers),
      ],
    );
  }
}
