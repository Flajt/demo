import 'package:demo/bloc/LocationsBloc.dart';
import 'package:demo/blocEvents/LocationBlocEvents.dart';
import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationTile extends StatelessWidget {
  const LocationTile(
      {Key? key, required this.blueprint})
      : super(key: key);

  final LocationBlueprint blueprint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color:Theme.of(context).accentColor)
      ),
      child: ListTile(
        leading: Icon(Icons.location_pin),
        title: Text(
          blueprint.name,
          overflow: TextOverflow.clip,
        ),
        onTap: (){
              BlocProvider.of<LocationBloc>(context).add(LocationBlocEventDelete(blueprint.hashCode));},
      ),
    );
  }
}
