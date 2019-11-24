/*import 'package:url_launcher/url_launcher.dart';

class MapUtils {

  // Launches googlemap on given coordinates.
  static openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl, forceSafariVC:false);
    } else {
      throw 'Could not open the map.';
    }
  }
}*/