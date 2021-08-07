import 'package:demo/api/chache.dart';
import 'package:demo/blocEvents/SearchBarEvents.dart';
import 'package:demo/blocStates/SearchBarState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  SearchBarBloc() : super(SearchBarInital([]));
  final Cache _cache = Cache();
  @override
  Stream<SearchBarState> mapEventToState(SearchBarEvent event) async* {  
    try{
    if(event is BuildSearchBarSuggestions){
      yield BuildSearchBar(_cache.searchLocations(event.query));
    }
    }catch(e){
      yield ErrorSearchBar(e);
    }
  }
}