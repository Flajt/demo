import 'package:demo/blueprints/RouteBlueprint.dart';
import 'package:equatable/equatable.dart';

abstract class CurrentRouteEvents extends Equatable{
  const CurrentRouteEvents();
  @override
  List<Object?> get props => [null];
}

class AddRoute extends CurrentRouteEvents{
  final RouteBlueprints route;
  const AddRoute(this.route) : super();
  @override
  List<Object?> get props => [route];
}
class RemoveRoute extends CurrentRouteEvents{
  const RemoveRoute();
  @override
  List<Object?> get props => [null];
}
