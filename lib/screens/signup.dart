import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meko/modal/gender.dart';
import 'package:meko/reusable_widgets/gender_widget.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/reusable_widgets/toast_message.dart';
import 'package:meko/screens/home_page.dart';
import 'package:meko/utils/color_utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  Gender selected = Gender.MALE;

  final usersCollection = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Name", Icons.person_outline, false, _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email Id", Icons.email_outlined, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Phone Number", Icons.phone_android_outlined,
                    false, _phoneTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Address", Icons.home_outlined, false,
                    _addressTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: GenderWidget(
                      onclick: () {
                        selected = Gender.MALE;
                        setState(() {
                          selected = Gender.MALE;
                        });
                      },
                      isSelected: Gender.MALE == selected,
                      icon: Icons.man_outlined,
                    )),
                    Expanded(
                        child: GenderWidget(
                      isSelected: Gender.FEMALE == selected,
                      onclick: () {
                        selected = Gender.FEMALE;
                        setState(() {
                          selected = Gender.FEMALE;
                        });
                      },
                      icon: Icons.woman_outlined,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    usersCollection.doc(value.user?.uid).set({
                      "name": _nameTextController.text,
                      "email": _emailTextController.text,
                      "phone": _phoneTextController.text,
                      "address": _addressTextController.text,
                      "gender": selected.name
                    }).then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(title: "Meko")))
                    ).onError((error, stackTrace) => ToastMessage.showMessage("Signup failed"));
                  }).onError((error, stackTrace) {
                    ToastMessage.showMessage("Signup failed");
                  });
                })
              ],
            ),
          ))),
    );
  }
}
