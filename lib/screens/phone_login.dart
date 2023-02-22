import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:meko/controller/authentication_controller.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';
import 'package:meko/reusable_widgets/toast_message.dart';
import 'package:meko/screens/navigation.dart';
import 'package:meko/utils/constants.dart';
import 'package:meko/utils/data_setup.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _phoneTextController = TextEditingController();
  final authController = Get.put(AuthenticationController());
  final formKey = GlobalKey<FormState>();

  bool isSendingOTP = false;
  bool isOTPSent = false;

  String authVerificationId = "";

  @override
  void initState() {
    super.initState();
    saveData();
  }

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
                      ...render()
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }

  List<Widget> render() {
    if (isOTPSent) {
      return verifyOtp();
    } else {
      return sendOtpWidget();
    }
  }

  List<Widget> sendOtpWidget() {
    var sendOtpButton = firebaseUIButton(context, "Send OTP", () {
      submitForm(context);
    });

    var sendingOtPMessage = const Text(
      "Sending OTP....",
      style: TextStyle(color: Colors.white, fontSize: 20),
    );
    var list = [
      reusableNumberTextField("Login with Phone Number", Icons.phone, false,
          PHONE_NUMBER_REGEX, "Enter valid phone number", _phoneTextController),
      const SizedBox(height: 30),
    ];
    return isSendingOTP
        ? [...list, sendingOtPMessage]
        : [...list, sendOtpButton];
  }

  List<Widget> verifyOtp() {
    return [
      const Text(
        "We texted you a code",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      const Text(
        "Please enter it below",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      const SizedBox(
        height: 30,
      ),
      OtpTextField(
        numberOfFields: 6,
        borderColor: Color(0xFF512DA8),
        filled: true,
        fillColor: Colors.white,
        showFieldAsBox: true,
        onCodeChanged: (String code) {},
        onSubmit: (String verificationCode) async {
          try {
            UserCredential user = await authController.verifyOtp(
                verificationCode, authVerificationId);
            goToUpdateProfile(user);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'invalid-verification-code') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Text("Invalid code"),
                      content: Text('You entered invalid code'),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Verification Failed"),
                      content: Text(e.toString()),
                    );
                  });
            }
          }
        }, // end onSubmit
      )
    ];
  }

  void goToUpdateProfile(UserCredential user) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Navigation(
                  uid: user.user!.uid,
                )));
  }

  void submitForm(BuildContext context) async {
    setState(() {
      authVerificationId = '';
      isSendingOTP = true;
      isOTPSent = false;
    });
    if (formKey.currentState!.validate()) {
      String phoneNo = _phoneTextController.text;
      await _auth.verifyPhoneNumber(
          phoneNumber: "+91$phoneNo",
          verificationCompleted: (credential) async {
            await _auth
                .signInWithCredential(credential)
                .then((value) => goToUpdateProfile(value));
          },
          codeSent: (verificationId, resendToken) {
            setState(() {
              authVerificationId = verificationId;
              isSendingOTP = false;
              isOTPSent = true;
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {
            setState(() {
              authVerificationId = verificationId;
              isSendingOTP = false;
              isOTPSent = true;
            });
          },
          verificationFailed: (e) {
            setState(() {
              isSendingOTP = false;
            });
            if (e.code == 'invalid-phone-number') {
              ToastMessage.showSnackMessage(
                  context, "Provided number is not valid");
            } else {
              ToastMessage.showSnackMessage(context, "Something went wrong");
            }
          });
    }
  }
}
