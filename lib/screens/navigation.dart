import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/user_controller.dart';
import 'package:meko/modal/user_model.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/screens/address-screen/address_book.dart';
import 'package:meko/screens/consumer/consumer_home.dart';
import 'package:meko/screens/update_profile.dart';
import 'package:meko/utils/utils.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key, required this.uid});

  final String uid;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: userController.getUser(widget.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                UserModel user = snapshot.data as UserModel;
                if (user.addressBook.isEmpty) {
                  return AddressBookWidget(
                    userId: widget.uid,
                  );
                }
                return ConsumerHomeWidget(
                    fullAddress: getFullAddress(user.addressBook.elementAt(0)));
              } else {
                return const UpdateProfile();
              }
            } else {
              return Container(
                color: Colors.black,
                child: Center(
                  child: logoWidget("assets/logo.png"),
                ),
              );
            }
          }),
    );
  }
}
