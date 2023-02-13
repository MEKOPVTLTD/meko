import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/reusable_widgets/toast_message.dart';
import 'package:meko/screens/address-screen/address_book.dart';
import 'package:meko/screens/reset_password.dart';
import 'package:meko/screens/signup.dart';
import 'package:meko/utils/constants.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                  child: Column(
                    children: <Widget>[
                      logoWidget("assets/logo.png"),
                      const SizedBox(height: 30),
                      reusableTextField(
                          "Enter Email",
                          Icons.person_outline,
                          false,
                          EMAIL_REGEX,
                          "Enter valid email",
                          _emailTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                          "Enter Password",
                          Icons.lock_outline,
                          true,
                          PASSWORD_REGEX,
                          "Enter valid password",
                          _passwordTextController),
                      const SizedBox(
                        height: 5,
                      ),
                      forgetPassword(context),
                      firebaseUIButton(context, "Sign In", () {
                        submitForm(context);
                      }),
                      signUpOption()
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        var userId = value.user?.uid;
        if (userId != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddressBookWidget(userId: userId)));
        }
      }).onError((error, stackTrace) {
        switch (error.toString()) {
          case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
            ToastMessage.showSnackMessage(
                context, "User not found. Please signup");
            break;
          default:
            ToastMessage.showSnackMessage(context, "Login Failed");
        }
      });
    }
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
