import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _item = [];

  List<Place> get items {
    return [..._item];
  }

  void addPlace(
    String title,
    File image,
  ) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: null);
    _item.add(newPlace);
    notifyListeners();
    DbHelper.insert('Places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }
}
