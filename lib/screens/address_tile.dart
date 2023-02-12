import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/user_controller.dart';
import 'package:meko/modal/address_model.dart';
import 'package:meko/modal/user_model.dart';
import 'package:meko/reusable_widgets/custom_alert.dart';

class AddressTile extends StatefulWidget {
  const AddressTile({
    super.key,
    required this.userId,
    required this.isLoadingAddress,
    required this.isSavingAddress,
    required this.updateIsSavingAddress
  });

  final String userId;
  final bool isLoadingAddress;
  final bool isSavingAddress;
  final Function updateIsSavingAddress;

  @override
  State<AddressTile> createState() => _AddressTileState();
}

class _AddressTileState extends State<AddressTile> {
  final addressController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
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
                              widget.updateIsSavingAddress(true);
                              Navigator.pop(context);
                              addressController
                                  .removeAddress(widget.userId, addressBook!)
                                  .then((value) {
                                widget.updateIsSavingAddress(false);
                              }).onError((error, stackTrace) {
                                widget.updateIsSavingAddress(false);
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
                return const Text("Please add address");
              }
            } else {
              return const Text("something went wrong. Please contact Administrator");
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  String getFullAddress(AddressModel? addressBook) {
    return "${addressBook?.name}, ${addressBook?.street}, ${addressBook?.locality},"
        " ${addressBook?.administrativeArea}, ${addressBook?.country}, ${addressBook?.postalCode}";
  }
}
