import 'package:demo/api/chache.dart';
import 'package:demo/bloc/LocationsBloc.dart';
import 'package:demo/bloc/SearchBarBlock.dart';
import 'package:demo/blocEvents/LocationBlocEvents.dart';
import 'package:demo/blocEvents/SearchBarEvents.dart';
import 'package:demo/blocStates/SearchBarState.dart';
import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:demo/uiblocks/LocationSuggestionTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:responsive_framework/responsive_row_column.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.size,
    required this.bloc,
    required this.cache,
    required this.geoCode, 
    required this.controller,
  }) : super(key: key);

  final Size size;
  final SearchBarBloc bloc;
  final Cache cache;
  final GeoCode geoCode;
  final FloatingSearchBarController controller;
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar( 
     actions: [
    FloatingSearchBarAction.searchToClear(
      showIfClosed: false,
    ),
    ],
      width: size.width,
    onQueryChanged: (query) async => bloc.add(BuildSearchBarSuggestions(query)),
    backdropColor: Colors.transparent,
    hint: 'Search place/address',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 800),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    openAxisAlignment: 0.0,
    debounceDelay: const Duration(milliseconds: 500),
    controller: controller,
    onSubmitted: (query) async {
      controller.close();
    try {
      Coordinates? location = cache.lookUpLocation(query);
      if (location != null) {
        LocationBlueprint blueprint = LocationBlueprint(query.capitalizeFirstofEach,location.latitude ?? 0, location.longitude ?? 0);
        context
            .read<LocationBloc>()
            .add(LocationBlocEventAdd(blueprint));
      } else {
        Coordinates c = await geoCode.forwardGeocoding(address: query);
        cache.cacheLocation(query, c);
        LocationBlueprint blueprint = LocationBlueprint(query, c.longitude ?? 0, c.latitude ?? 0);
        context
            .read<LocationBloc>()
            .add(LocationBlocEventAdd(blueprint));
      }
    } catch (e) {
      }
    },
    builder:(BuildContext context, Animation<double> transition) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8)),
        child: Material(
          color: Colors.white,
          elevation: 10.0,
            child: BlocBuilder<SearchBarBloc, SearchBarState>(
          bloc: bloc,
          builder: (context, state) {
            return ResponsiveRowColumn(
              layout: ResponsiveRowColumnType.COLUMN,
              children: [
                ...state.value.map((e) => ResponsiveRowColumnItem(
                        child: LocationSuggestionTile(blueprint: e) 
                      
                ))
              ],
            );
          },
        )));
    },
    );
  }
}
