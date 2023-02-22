import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:meko/repository/authentication_repository.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());



  Future<void> phoneAuthentication(String phoneNumber) async {
    return await _authRepo.phoneAuthentication(phoneNumber);
  }

  Future<UserCredential> verifyOtp(String otp, String verificationId) async {
    return await _authRepo.verifyOtp(otp, verificationId);
  }
}
