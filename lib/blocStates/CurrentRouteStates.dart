import 'package:demo/blueprints/RouteBlueprint.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentRouteState extends Equatable{
  final RouteBlueprints? route;
  const CurrentRouteState(this.route);
  @override
  List<Object?> get props => [route];
}

class InitalRouteState extends CurrentRouteState{
  InitalRouteState(RouteBlueprints? route) : super(route);
}
class UpdateCurrentRouteState extends CurrentRouteState{
  UpdateCurrentRouteState(RouteBlueprints? route) : super(route);

}

class ErrorRouteState extends CurrentRouteState{
  final Object e;
  @override
  ErrorRouteState(this.e) : super(null);

}