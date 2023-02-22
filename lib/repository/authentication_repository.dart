import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:meko/modal/category_model.dart';

class AuthenticationRepository extends GetxService {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  var verificationId = ''.obs;

  Future<void> phoneAuthentication(String phoneNumber) async {

    return await _auth.verifyPhoneNumber(
        phoneNumber:  "+91$phoneNumber",
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar("Error", "Provided number is not valid");
          } else {
            Get.snackbar("Error", "Something went wrong");
          }
        });
  }

  Future<UserCredential> verifyOtp(String otp, String verificationId) async {
    return await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp));

  }
}
