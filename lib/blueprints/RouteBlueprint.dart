import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:equatable/equatable.dart';
///Blueprint for a Route
class RouteBlueprints extends Equatable{
  late final List<LocationBlueprint> locations;
  RouteBlueprints(this.locations);
  
  RouteBlueprints.fromJson(Map json) {
    List<LocationBlueprint> _l = []; 
    json["locations"]?.forEach((element) { 
      _l.add(LocationBlueprint.fromJson(element));
    });
    this.locations=_l;
  }
  
  toJson(){
    List<Map> _locationsArray = [];
    locations.forEach((element) { 
      _locationsArray.add(element.toJson());
    });
    return {"locations": _locationsArray};
  }

  @override
  List<Object?> get props => [locations];

  
}