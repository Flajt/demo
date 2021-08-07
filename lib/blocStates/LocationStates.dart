import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:equatable/equatable.dart';

abstract class LocationBlockStates extends Equatable{
  final List<LocationBlueprint> value;
  const LocationBlockStates(this.value);

  @override
  List<Object?> get props => [value];
}
class InitalLocationState extends LocationBlockStates{
  final List <LocationBlueprint> inital;
  const InitalLocationState(this.inital) : super(inital);
  @override
  List<Object?> get props => [inital];
}

class UpdateLocationsState extends LocationBlockStates{
  UpdateLocationsState(List<LocationBlueprint> value) : super(value);
  @override
  List<Object?> get props => [value];

}
class ArchivelocationState extends LocationBlockStates{
  ArchivelocationState(value) : super(value);
  @override get props =>[value];
}
class GetLocationState extends LocationBlockStates{
  GetLocationState(List<LocationBlueprint> value) : super(value);
  @override
  get props =>[value];
}

class ErrorLocationState extends LocationBlockStates{
  final Object e;
  ErrorLocationState(this.e) : super([]);
  @override
  get props => [this.e,[]];
}