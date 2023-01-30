import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meko/screens/location_denied.dart';
import 'package:meko/services/geolocator_widget.dart';

import 'home.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return AddressWidgetState();
  }
}

class AddressWidgetState extends State<AddressWidget> {

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
            print("******************");
            print(snapshot.data?.latitude);
            print(snapshot.data?.longitude);
            var d = Geolocator.distanceBetween(24.46768905241226, 85.59336475380167,
                22.75818784537122, 86.20441376912656)/1000;
            print(d);
            print("******************");

            return HomeWidget();
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

  void showMessage(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
