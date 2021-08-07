import 'package:demo/blocEvents/RoutesEvents.dart';
import 'package:demo/blocStates/RouteStates.dart';
import 'package:demo/blueprints/RouteBlueprint.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';


class RoutesBloc extends HydratedBloc<RoutesEvents, RouteStates> {
  RoutesBloc() : super(InitalRoutesState([]));
  
  @override
  fromJson(Map<String, dynamic> json) {
    List routes = json["routes"];
    List<RouteBlueprints> finalRoutes = [];
    routes.forEach((element) {
      finalRoutes.add(RouteBlueprints.fromJson(element));
    });
    return InitalRoutesState(finalRoutes);
  }

  @override
  Stream<RouteStates> mapEventToState(RoutesEvents event) async* {
    try {
      if (event is AddRoute) {
        yield UpdateRoutesState(state.routes..add(event.route));
      }
      if (event is DeleteRoute) {
        yield UpdateRoutesState(state.routes
          ..removeWhere((element) => element.hashCode == event.hash));
      }
    } catch (e) {
      yield ErrorRoutesState(e);
    }
  }

  @override
  Map<String, dynamic>? toJson(state) {
    List _routes = [];
    if (state.routes.isNotEmpty) {
      state.routes.forEach((element) {
        _routes.add(element?.toJson());
      });
    }
    return {"routes": _routes};
  }
}
