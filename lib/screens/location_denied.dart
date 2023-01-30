import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meko/services/geolocator_widget.dart';
import 'package:meko/utils/color_utils.dart';

import 'home.dart';

class LocationDenied extends StatefulWidget {
  const LocationDenied({super.key, required this.error});

  final String error;

  @override
  State<StatefulWidget> createState() {
    return LocationDeniedState();
  }
}

class LocationDeniedState extends State<LocationDenied> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: [
                  Center(child: Text(
                    widget.error,
                    style: TextStyle(fontSize: 20),
                  ),
                  ),
                  Center( child: TextButton(
                    child: const Text(
                      "Enable Location Service",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                      textAlign: TextAlign.right,
                    ),
                    onPressed: () => _openAppSettings(),
                  ),)
                ]
            ),
        ),
      )

    );
  }


  void _openAppSettings() async {
    await Geolocator.openAppSettings();
  }

}