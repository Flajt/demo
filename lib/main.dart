import 'package:demo/bloc/LocationsBloc.dart';
import 'package:demo/uiblocks/LocationTile.dart';
import 'package:demo/uiblocks/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:path_provider/path_provider.dart';

import 'api/chache.dart';
import 'bloc/CurrentRouteBloc.dart';
import 'bloc/RoutesBlock.dart';
import 'bloc/SearchBarBlock.dart';
import 'blocEvents/LocationBlocEvents.dart';
import 'blocEvents/RoutesEvents.dart';
import 'blocStates/LocationStates.dart';
import 'blueprints/RouteBlueprint.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationSupportDirectory());
  Cache().init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LocationBloc()),
              BlocProvider(create: (context) => RoutesBloc()),
              BlocProvider(create: (context) => CurrentRoute()),
              BlocProvider(create: (context) => SearchBarBloc())
  ],child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddRoutesPage()
    );
  }
}


class AddRoutesPage extends StatefulWidget {
  const AddRoutesPage();
  @override
  _AddRoutesPageState createState() => _AddRoutesPageState();
}

class _AddRoutesPageState extends State<AddRoutesPage> {
  late GeoCode geoCode;
  late Cache cache;
  //late SearchBarBloc bloc;
  late FloatingSearchBarController controller;
  @override
  void initState() {
    super.initState();
    geoCode = GeoCode();
    cache = Cache();
    //bloc = SearchBarBloc();
    controller = FloatingSearchBarController();
  }

  @override
  Widget build(BuildContext context) {
    //final locationBloc = BlocProvider.of<LocationBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
              width: size.width,
              height: size.height,
              child: Container(
                  child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * .3,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        SearchBar(
                          size: size,
                          bloc: context.read<SearchBarBloc>(),
                          cache: cache,
                          geoCode: geoCode,
                          controller: controller,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<LocationBloc, LocationBlockStates>(
                      builder: (context, state) {
                        print("-------------");
                        print(state);
                        print("-------------");
                        if (state.value.isNotEmpty) {
                          return ListView.builder(
                              itemCount: state.value.length,
                              itemBuilder: (context, index) => LocationTile(
                                    blueprint: state.value[index],
                                  ));
                        } else {
                          return Align(
                              child: Container(
                            child: Text(
                              "No places added",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 24.0),
                            ),
                          ));
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(50, 50),
                          primary: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          LocationBlockStates states = context.read<LocationBloc>().state;
                          if (states.value.isNotEmpty) {
                            context
                                .read<RoutesBloc>()
                                .add(AddRoute(RouteBlueprints(states.value)));
                            context
                                .read<LocationBloc>()
                                .add(LocationBlocEventDeleteAll());
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )),
            ),
          ),
        );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

