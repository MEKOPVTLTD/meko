import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meko/screens/location_denied.dart';
import 'package:meko/services/geolocator_widget.dart';

import 'grid_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  late Future<Position> futurePositions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: FutureBuilder<Position>(
        future: futurePositions,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return GridBuilder();
          } else if (snapshot.hasError) {
            return LocationDenied(error: snapshot.error.toString());
          }
          return const CircularProgressIndicator();
        },
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    futurePositions = determinePosition();
  }

}
