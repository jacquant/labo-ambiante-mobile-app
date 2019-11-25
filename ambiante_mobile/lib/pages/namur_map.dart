import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ambiante_mobile/data/locaux_parser.dart';
import 'package:latlong/latlong.dart';

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
    var dataJson = await loadLocaux();

    setState(() {
      // re-initialize the list of markers
      markers = [];

      for (var event in dataJson['events']['namur']) {
        String eventName = event['name'];
        var coordXY = LatLng(
            double.parse(event['coordX']), double.parse(event['coordY']));
        markers.add(createMarker(eventName, coordXY));
      }
    });
  }

  // This fct creates a Marker and place it on the coordinate XY
  Marker createMarker(String id, LatLng coordXY) {
    var info = _infoEvent(id, coordXY);

    var marker = Marker(
      width: 35.0,
      height: 35.0,
      point: coordXY,
      builder: (context) => IconButton(
        icon: Icon(Icons.music_note),
        color: Theme.of(context).accentColor,
        iconSize: 45.0,
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
    );

    return marker;
  }

  List<Widget> _infoEvent(String id, LatLng coordXY) {
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
            //MapUtils.openMap(coordXY.latitude, coordXY.longitude);
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
            'accessToken': 'pk.eyJ1IjoiamFjcXVhbnQiLCJhIjoiY2syeHFpemxqMDAxYzNsbXFrcWwwOGxmbyJ9.F94lOloBRxltcsySUlvwGA',
            'id': 'mapbox.streets',
          },
          ),
        MarkerLayerOptions(markers: markers),
      ],
    );
  }
}
