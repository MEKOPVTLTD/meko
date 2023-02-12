import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meko/controller/address_controller.dart';
import 'package:meko/modal/address_model.dart';
import 'package:meko/modal/user_model.dart';
import 'package:meko/reusable_widgets/custom_alert.dart';
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
        renderHeader(context),
        const SizedBox(height: 50),
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        const SizedBox(height: 50),
        getLoadingMessage(),
      ];
    }
    return [renderHeader(context), Expanded(child: renderAddressTile(context))];
  }

  Widget getLoadingMessage() {
    if (isLoadingAddress) {
      return Text(LOADING_ADDRESS);
    } else {
      return Text(SAVING_ADDRESS);
    }
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
                      if (!isLoadingAddress || !isSavingAddress) {
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
        ));
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

      var saveAddress = [
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

      String address =
          "${placemark.name}, ${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}";
      customAlertMessage(context, YOUR_ADDRESS, address, saveAddress);
    } catch (e) {
      setState(() {
        isLoadingAddress = false;
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
    return FutureBuilder(
        future: addressController.getUser(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userModel = snapshot.data as UserModel;
              if (userModel.addressBook != null &&
                  userModel.addressBook!.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: userModel.addressBook?.length,
                    itemBuilder: (context, index) {
                      var addressBook = userModel.addressBook?.elementAt(index);
                      var fullAddress = getFullAddress(addressBook);

                      var removeAddress = [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isSavingAddress = true;
                              });
                              Navigator.pop(context);
                              addressController
                                  .removeAddress(widget.userId, addressBook!)
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
                            child: const Text("Remove")),
                        TextButton(
                            onPressed: () => {Navigator.pop(context)},
                            child: const Text("Cancel"))
                      ];

                      return Card(
                        color: Colors.white.withOpacity(.6),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListTile(
                            title: Text(fullAddress),
                            trailing: SizedBox(
                              width: 30,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: IconButton(
                                    onPressed: () {
                                      customAlertMessage(
                                          context,
                                          "Remove Address",
                                          "Address will be removed permanent",
                                          removeAddress);
                                    },
                                    icon: const Icon(Icons.delete),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Text("Please add address");
              }
            } else {
              return Text("something went wrong. Please contact Administrator");
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  String getFullAddress(AddressModel? addressBook) {
    return "${addressBook?.name}, ${addressBook?.street}, ${addressBook?.locality},"
        " ${addressBook?.administrativeArea}, ${addressBook?.country}, ${addressBook?.postalCode}";
  }
}
