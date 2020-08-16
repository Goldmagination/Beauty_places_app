import 'package:flutter/foundation.dart';

import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _item = [];


  List<Place> get items{
    return [..._item];
  }
}
