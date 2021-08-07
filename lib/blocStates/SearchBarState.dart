import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:equatable/equatable.dart';

abstract class SearchBarState extends Equatable{
  final List<LocationBlueprint> value;
  const SearchBarState(this.value);

  @override
  get props => [value];
}

class BuildSearchBar extends SearchBarState{
  final List<LocationBlueprint> value;
  const BuildSearchBar(this.value) : super(value);
}
class SearchBarInital extends SearchBarState{
  final List<LocationBlueprint> value;
  SearchBarInital(this.value) : super(value);
}

class ErrorSearchBar extends SearchBarState{
  final Object e;
  ErrorSearchBar(this.e) : super([]);
}