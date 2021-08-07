import 'package:equatable/equatable.dart';

abstract class SearchBarEvent extends Equatable{
  const SearchBarEvent();

  @override
  get props =>[];
}

class BuildSearchBarSuggestions extends SearchBarEvent{
  final String query;
  const BuildSearchBarSuggestions(this.query);
  @override
  get props =>[query];
}