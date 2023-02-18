import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/user_controller.dart';
import 'package:meko/modal/user_model.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/screens/address-screen/address_book.dart';
import 'package:meko/screens/consumer/consumer_home.dart';
import 'package:meko/screens/signin.dart';
import 'package:meko/utils/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userController = Get.put(UserController());

  var auth = FirebaseAuth.instance;
  var isLoggedIn = false;

  @override
  void initState() {
    checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? FutureBuilder(
            future: userController.getUser(auth.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  if(user.addressBook.isEmpty) {
                    return AddressBookWidget(userId: auth.currentUser!.uid,);
                  }
                  return ConsumerHomeWidget(
                      fullAddress:
                          getFullAddress(user.addressBook.elementAt(0)));
                } else {
                  return const SignIn();
                }
              } else {
                return  Container(
                    color: Colors.black,
                    child: Center(
                      child: logoWidget("assets/logo.png"),
                    ),
                );
              }
            })
        : const SignIn();
  }

  void checkIfLoggedIn() {
    auth.authStateChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
  }
}
