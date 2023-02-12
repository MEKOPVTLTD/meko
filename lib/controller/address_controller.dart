import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meko/modal/address_model.dart';
import 'package:meko/modal/user_model.dart';
import 'package:meko/repository/address_repository.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  // final usersCollection = FirebaseFirestore.instance.collection('User');

  final _addressRepo = Get.put(AddressRepository());

  Future<void> updateAddress(String uuid, AddressModel addressModel) async {
    return await _addressRepo.addAddress(uuid, addressModel);
  }

  Future<void> removeAddress(String uuid, AddressModel addressModel) async {
    return await _addressRepo.removeAddress(uuid, addressModel);
  }

  Future<UserModel?> getUser(String uuid) async {
    return await _addressRepo.geUser(uuid);
  }
}