import 'package:demo/blocEvents/CurrentRouteEvents.dart';
import 'package:demo/blocStates/CurrentRouteStates.dart';
import 'package:demo/blueprints/RouteBlueprint.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
class CurrentRoute
    extends HydratedBloc<CurrentRouteEvents, CurrentRouteState> {
  CurrentRoute() : super(InitalRouteState(null));

  @override
  fromJson(Map<String, dynamic> json) {
    if (json["locations"] != null) {
      return InitalRouteState(RouteBlueprints.fromJson(json));
    } else {
      return InitalRouteState(null);
    }
  }

  @override
  Stream<CurrentRouteState> mapEventToState(CurrentRouteEvents event) async* {
    try {
      if (event is AddRoute) {
        yield UpdateCurrentRouteState(event.route);
      }
      if (event is RemoveRoute) {
        yield InitalRouteState(null);
      }
    } catch (e) {
      yield ErrorRouteState(e);
    }
  }

  @override
  Map<String, dynamic>? toJson(state) => state.route?.toJson();
}
