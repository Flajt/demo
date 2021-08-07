import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
abstract class LocationBlocEvents extends Equatable{
  const LocationBlocEvents();
  @override
  List<Object?> get props => [];
  
}

///Delete Entry Event
class LocationBlocEventDelete extends LocationBlocEvents {
  const LocationBlocEventDelete(this.hash);
  final int hash;

  @override
  List<Object?> get props => [hash];
}
///Deletes entry
class LocationBlocEventAdd extends LocationBlocEvents {
  const LocationBlocEventAdd(this.locationBlueprint);
  final LocationBlueprint locationBlueprint;

  @override
  List<Object?> get props => [locationBlueprint];
}

class LocationBlocEventDeleteAll extends LocationBlocEvents{
  const LocationBlocEventDeleteAll();

  @override
  List<Object?> get props =>[null];
}
