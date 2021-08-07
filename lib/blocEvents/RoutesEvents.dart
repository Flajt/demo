import 'package:demo/blueprints/RouteBlueprint.dart';
import 'package:equatable/equatable.dart';

abstract class RoutesEvents extends Equatable{
  const RoutesEvents();
  @override
  get props => [];
}

class AddRoute extends RoutesEvents{
  final RouteBlueprints route;
  const AddRoute(this.route);

  @override
  get props=>[route];
}
class DeleteRoute extends RoutesEvents{
  final int hash;
  const DeleteRoute(this.hash);

  @override 
  get props => [hash];
}