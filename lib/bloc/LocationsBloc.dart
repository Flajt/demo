import 'package:demo/blocEvents/LocationBlocEvents.dart';
import 'package:demo/blocStates/LocationStates.dart';
import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocationBloc extends HydratedBloc<LocationBlocEvents, LocationBlockStates> {
  LocationBloc() : super(InitalLocationState([]));
  @override
  LocationBlockStates fromJson(Map<String, dynamic> json) {
    //print(json);//{locations: [{name: Berlin Hauptbahnhof, longitude: 13.36933, latitude: 52.5251}]}
    List<dynamic> locations = json["locations"];
    List<LocationBlueprint> blueprints = [];
    if (locations.isNotEmpty) {
      locations.forEach((element) {
        blueprints.add(LocationBlueprint.fromJson(element));
      });
    }
    return InitalLocationState(blueprints);
  }

  @override
  Stream<LocationBlockStates> mapEventToState(LocationBlocEvents event) async* {
    try {
      if (event is LocationBlocEventAdd) {
        List<LocationBlueprint> blueprints = state.value;
        yield UpdateLocationsState(List.from(blueprints..add(event.locationBlueprint)));
      } else if (event is LocationBlocEventDelete) {
        List<LocationBlueprint> blueprints = state.value;
        blueprints.removeWhere((element) => element.hashCode == event.hash);
        yield UpdateLocationsState(blueprints);
      } else if (event is LocationBlocEventDeleteAll) {
        yield InitalLocationState([]);
      }
    } catch (e) {
      yield ErrorLocationState(e);
    }
  }

  @override
  Map<String, dynamic>? toJson(LocationBlockStates state) {
    Map<String, List<Map>> storage = {"locations": []};
    if (state.value.isNotEmpty) {
      state.value.forEach((element) {
        storage["locations"]?.add(element.toJson());
      });
    }
    return storage;
  }
}
