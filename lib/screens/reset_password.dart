import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/utils/color_utils.dart';
import 'package:meko/utils/constants.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
              "Reset Password",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                          "Enter Email Id",
                          Icons.person_outline,
                          false,
                          EMAIL_REGEX,
                          "Enter valid email",
                          _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, "Reset Password", () {
                        submitForm(context);
                      })
                    ],
                  ),
                ))),
          )),
    );
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailTextController.text)
          .then((value) => Navigator.of(context).pop());
    }
  }
}
