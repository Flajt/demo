import 'package:demo/blueprints/RouteBlueprint.dart';
import 'package:equatable/equatable.dart';

abstract class RouteStates extends Equatable{
  final List<RouteBlueprints?> routes;
  const RouteStates(this.routes);

  @override
  get props => [routes];
}
class LoadRoutesState extends RouteStates{
  LoadRoutesState() : super([]);

  @override
  get props=>[[]];
}

class InitalRoutesState extends RouteStates{
  InitalRoutesState(List<RouteBlueprints?> routes) : super(routes);
}


class UpdateRoutesState extends RouteStates{
  UpdateRoutesState(List<RouteBlueprints?> routes) : super(routes);
}
class ErrorRoutesState extends RouteStates{
  ///Error 
  final Object e;
  ErrorRoutesState(this.e) : super([]);

}