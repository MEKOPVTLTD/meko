import 'package:meko/modal/address_model.dart';
import 'package:meko/modal/gender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? name;
  final String? phone;
  final Gender? gender;
  final String? email;
  final List<AddressModel>? addressBook;

  UserModel(
    this.name,
    this.phone,
    this.gender,
    this.email,
    this.addressBook,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
