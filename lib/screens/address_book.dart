import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meko/reusable_widgets/custom_alert.dart';
import 'package:meko/services/geolocator_widget.dart';
import 'package:meko/utils/constants.dart';

class AddressBookWidget extends StatefulWidget {
  const AddressBookWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return AddressBookWidgetState();
  }
}

class AddressBookWidgetState extends State<AddressBookWidget> {
  bool isLoadingAddress = false;
  late Future<Position> futurePositions;
  List<String> address = [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Column(
        children: render(context),
      ),
    ));
  }

  List<Widget> render(BuildContext context) {
    if(isLoadingAddress) {
      return [
        renderHeader(context),
        SizedBox(height: 50),
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        SizedBox(height: 50),
        Text(LOADING_ADDRESS),
      ];
    }
    return [
        renderHeader(context),
        Expanded(child: renderAddressTile(context))
      ];
  }

  Widget renderHeader(BuildContext context) {
    return Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.08, 0, 0),
          child: ListTile(
            title: const Text(
              "Select Address",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            trailing: SizedBox(
              width: 40,
              child: Row(
                children: [
                  Expanded(
                      child: IconButton(
                    onPressed: () {
                      if (!isLoadingAddress) {
                        addAddress(context);
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ))
                ],
              ),
            ),
          ),
          // Text("Service For Address", style: TextStyle(color: Colors.white, fontSize: 20),),
        ));
  }

  void addAddress(BuildContext context) async {
    setState(() {
      isLoadingAddress = true;
    });
    var saveAddress = [
      TextButton(onPressed: () => {}, child: const Text(SAVE)),
      TextButton(
          onPressed: () => {Navigator.pop(context)}, child: const Text(OK))
    ];

    try {
      final position = await determinePosition();
      List<Placemark> places =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        isLoadingAddress = false;
      });
      Placemark placemark = places.elementAt(0);
      String address =
          "${placemark.name}, ${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}";
      customAlertMessage(context, YOUR_ADDRESS, address, saveAddress);
    } catch (e) {
      setState(() {
        isLoadingAddress = true;
      });
      var locationServiceAction = [
        TextButton(
            onPressed: () => {Geolocator.openLocationSettings()},
            child: const Text(ENABLE_LOCATION_MSG)),
        TextButton(
            onPressed: () => {Navigator.pop(context)}, child: const Text(OK))
      ];
      var appLocationServiceAction = [
        TextButton(
            onPressed: () => {Geolocator.openAppSettings()},
            child: const Text(ENABLE_APP_LOCATION_MSG)),
        TextButton(
            onPressed: () => {Navigator.pop(context)}, child: const Text(OK))
      ];
      switch (e) {
        case LOCATION_PERMISSION_DENIED:
          break;
        case LOCATION_SERVICE_DISABLED:
          customAlertMessage(context, ENABLE_LOCATION_MSG, e.toString(),
              locationServiceAction);
          break;
        case LOCATION_PERMISSION_PERMANENT_DENIED:
          customAlertMessage(context, ENABLE_APP_LOCATION_MSG, e.toString(),
              appLocationServiceAction);
          break;
      }
    }
  }

  Widget renderAddressTile(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        itemCount: address.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white.withOpacity(.6),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListTile(
                title: Text(address[index]),
                trailing: SizedBox(
                  width: 30,
                  child: Row(
                    children: [
                      Expanded(
                          child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
