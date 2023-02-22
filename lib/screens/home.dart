import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meko/screens/phone_login.dart';
import 'package:meko/screens/navigation.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        ? Navigation(
            uid: auth.currentUser!.uid,
          )
        : const PhoneLogin();
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
