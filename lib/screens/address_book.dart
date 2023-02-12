import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meko/controller/address_controller.dart';
import 'package:meko/modal/address_model.dart';
import 'package:meko/reusable_widgets/custom_alert.dart';
import 'package:meko/screens/address_header.dart';
import 'package:meko/screens/address_tile.dart';
import 'package:meko/services/geolocator_widget.dart';
import 'package:meko/utils/constants.dart';

class AddressBookWidget extends StatefulWidget {
  const AddressBookWidget({super.key, required this.userId});

  final String userId;

  @override
  State<StatefulWidget> createState() {
    return AddressBookWidgetState();
  }
}

class AddressBookWidgetState extends State<AddressBookWidget> {
  bool isLoadingAddress = false;
  bool isSavingAddress = false;
  final addressController = Get.put(AddressController());

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
    if (isSavingAddress || isLoadingAddress) {
      return [
        AddressHeader(
          isLoadingAddress: isLoadingAddress,
          isSavingAddress: isSavingAddress,
          addAddress: () => {addAddress(context)},
        ),
        const SizedBox(height: 50),
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        const SizedBox(height: 50),
        getLoadingMessage(),
      ];
    }
    return [
      AddressHeader(
        isLoadingAddress: isLoadingAddress,
        isSavingAddress: isSavingAddress,
        addAddress: () => {addAddress(context)},
      ),
      Expanded(
          child: AddressTile(
              userId: widget.userId,
              isLoadingAddress: isLoadingAddress,
              isSavingAddress: isSavingAddress,
              updateIsSavingAddress: (value) {
                updateIsSavingAddress(value);
              }))
    ];
  }

  Widget getLoadingMessage() {
    if (isLoadingAddress) {
      return Text(LOADING_ADDRESS);
    } else {
      return Text(SAVING_ADDRESS);
    }
  }

  void addAddress(BuildContext context) async {
    setState(() {
      isLoadingAddress = true;
    });

    try {
      final position = await determinePosition();
      List<Placemark> places =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        isLoadingAddress = false;
      });
      Placemark placemark = places.elementAt(0);
      AddressModel addressModel = AddressModel(
          placemark.name,
          placemark.street,
          placemark.locality,
          placemark.administrativeArea,
          placemark.country,
          placemark.postalCode,
          position.latitude,
          position.longitude);

      var saveAddress = saveAddressActions(context, addressModel);

      String address =
          "${placemark.name}, ${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}";
      customAlertMessage(context, YOUR_ADDRESS, address, saveAddress);
    } catch (e) {
      setState(() {
        isLoadingAddress = false;
      });
      var locationServiceAction = goToLocationServiceAction(context);
      var appLocationServiceAction = goToAppLocationService(context);
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

  List<TextButton> goToAppLocationService(BuildContext context) {
    return [
      TextButton(
          onPressed: () => {Geolocator.openAppSettings()},
          child: const Text(ENABLE_APP_LOCATION_MSG)),
      TextButton(
          onPressed: () => {Navigator.pop(context)}, child: const Text(OK))
    ];
  }

  List<TextButton> goToLocationServiceAction(BuildContext context) {
    return [
      TextButton(
          onPressed: () => {Geolocator.openLocationSettings()},
          child: const Text(ENABLE_LOCATION_MSG)),
      TextButton(
          onPressed: () => {Navigator.pop(context)}, child: const Text(OK))
    ];
  }

  List<TextButton> saveAddressActions(
      BuildContext context, AddressModel addressModel) {
    return [
      TextButton(
          onPressed: () {
            setState(() {
              isSavingAddress = true;
            });
            Navigator.pop(context);
            addressController
                .updateAddress(widget.userId, addressModel)
                .then((value) {
              setState(() {
                isSavingAddress = false;
              });
            }).onError((error, stackTrace) {
              setState(() {
                isSavingAddress = false;
              });
            });
          },
          child: const Text(SAVE)),
      TextButton(
          onPressed: () => {Navigator.pop(context)}, child: const Text(OK))
    ];
  }

  void updateIsSavingAddress(bool value) {
    setState(() {
      isSavingAddress = value;
    });
  }
}
