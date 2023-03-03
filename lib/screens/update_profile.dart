import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meko/modal/gender.dart';
import 'package:meko/reusable_widgets/gender_widget.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/reusable_widgets/toast_message.dart';
import 'package:meko/screens/address-screen/address_book.dart';
import 'package:meko/utils/constants.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Gender selected = Gender.MALE;
  User? user;
  var _auth = FirebaseAuth.instance;

  final usersCollection = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
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
                          logoWidget("assets/logo.png"),
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
                          firebaseUIButton(context, "Update Profile", () {
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
      usersCollection.doc(_auth.currentUser!.uid).set({
        "name": _nameTextController.text,
        "email": _emailTextController.text,
        "phone": _auth.currentUser?.phoneNumber,
        "gender": selected.name,
        "addressBook": [],
        "type": "consumer"
      }).then((value) {
        var uid = _auth.currentUser?.uid;
        if (uid != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddressBookWidget(
                        userId: uid,
                      )));
        } else {
          ToastMessage.showMessage("Update failed");
        }
      }).onError((error, stackTrace) {
        ToastMessage.showMessage("Update failed");
      });
    }
  }
}
