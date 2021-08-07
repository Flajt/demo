import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:geocode/geocode.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Cache {
  static final Cache _instance = Cache._internal();
  factory Cache() => _instance;
  Cache._internal();
  late Box _box;

  void init() async {
    _box = await Hive.openBox("locationCache",
        path: (await getApplicationSupportDirectory()).path);
  }

  void cacheLocation(String locationName, Coordinates coordinates) async {
    await _box.put(locationName.toLowerCase(),
        [coordinates.latitude, coordinates.longitude]);
  }

  Coordinates? lookUpLocation(String location) {
    try {
      List cords = _box.get(location.toLowerCase());
      return Coordinates(latitude: cords[0], longitude: cords[1]);
    } catch (e) {
      return null;
    }
  }

  List<LocationBlueprint> searchLocations(String query) {
    List<LocationBlueprint> blueprints = [];
    List matches = _box.keys
        .where((element) => element.contains(query.toLowerCase()))
        .toList();
    matches.forEach((element) {
      Coordinates? coordinates = lookUpLocation(element);
      if (coordinates != null) {
        blueprints.add(LocationBlueprint(
            element, coordinates.latitude ?? 0, coordinates.longitude ?? 0));
      }
    });
    return blueprints;
  }
}
