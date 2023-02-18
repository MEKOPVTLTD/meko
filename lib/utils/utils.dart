import 'package:meko/modal/address_model.dart';

String getFullAddress(AddressModel? addressBook) {
  return "${addressBook?.name}, ${addressBook?.street}, ${addressBook?.locality},"
      " ${addressBook?.administrativeArea}, ${addressBook?.postalCode}";
}