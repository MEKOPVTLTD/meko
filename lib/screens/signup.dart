import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meko/modal/gender.dart';
import 'package:meko/reusable_widgets/gender_widget.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/reusable_widgets/toast_message.dart';
import 'package:meko/screens/address_book.dart';
import 'package:meko/utils/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Gender selected = Gender.MALE;
  User? user;

  final usersCollection = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
            color: Colors.black,
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Name",
                              Icons.person_outline,
                              false,
                              NAME_REGEX,
                              "Enter valid name",
                              _nameTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Email Id",
                              Icons.email_outlined,
                              false,
                              EMAIL_REGEX,
                              "Enter valid email",
                              _emailTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Phone Number",
                              Icons.phone_android_outlined,
                              false,
                              PHONE_NUMBER_REGEX,
                              "Enter valid phone number",
                              _phoneTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Enter Password",
                              Icons.lock_outlined,
                              true,
                              PASSWORD_REGEX,
                              "Enter valid password",
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
                            submitForm(context);
                          })
                        ],
                      ),
                    )))),
      ),
    );
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        user = value.user;
        return usersCollection.doc(value.user?.uid).set({
          "name": _nameTextController.text,
          "email": _emailTextController.text,
          "phone": _phoneTextController.text,
          "gender": selected.name,
          "type": "consumer"
        }).then((value) {
          var uid = user?.uid;
          if (uid != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddressBookWidget(
                          userId: uid,
                        )));
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddressBookWidget(
                        userId: "fvfkn",
                      )));
        }).onError((error, stackTrace) {
          ToastMessage.showMessage("Signup failed");
        });
      }).onError((error, stackTrace) {
        ToastMessage.showMessage("Signup failed");
      });
    }
  }
}
