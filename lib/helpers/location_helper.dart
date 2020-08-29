import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLEAPIKEY = 'AIzaSyCO92Yi-9hHM0tL7oTu1pdnBAbl9v0l1eI';

class LocationMethod {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLEAPIKEY';
  }

  static Future<String> getPlaceAdress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLEAPIKEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
