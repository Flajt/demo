import 'package:demo/bloc/LocationsBloc.dart';
import 'package:demo/blocEvents/LocationBlocEvents.dart';
import 'package:demo/blueprints/LocationBlueprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LocationSuggestionTile extends StatelessWidget {
  const LocationSuggestionTile({Key? key, required this.blueprint}) : super(key: key);
  final LocationBlueprint blueprint;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).accentColor),borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: ListTile(
        leading: Icon(Icons.place,color: Theme.of(context).primaryColor),
        title: Text(blueprint.name),
        onTap: ()=>(context).read<LocationBloc>().add(LocationBlocEventAdd(blueprint)),
      ),
    );
  }
}