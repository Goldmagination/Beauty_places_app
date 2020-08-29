import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _item = [];

  List<Place> get items {
    return [..._item];
  }

  Place findbyId(String id) {
    return _item.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation selectedPlace) async {
    final address = await LocationMethod.getPlaceAdress(
        selectedPlace.latitude, selectedPlace.longitude);
    final updateLocation = PlaceLocation(
      latitude: selectedPlace.latitude,
      longitude: selectedPlace.longitude,
      address: address,
    );
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: updateLocation);
    _item.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> getPlace() async {
    final dataList = await DbHelper.fetchData('user_places');
    _item = dataList
        .map(
          (e) => Place(
            id: e['id'],
            image: File(e['image']),
            title: e['title'],
            location: PlaceLocation(
                latitude: e['loc_lat'],
                longitude: e['loc_lng'],
                address: e['address']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
