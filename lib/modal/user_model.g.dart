// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['name'] as String,
      json['phone'] as String,
      $enumDecode(_$GenderEnumMap, json['gender']),
      json['email'] as String,
      (json['addressBook'] as List<dynamic>)
          .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'gender': _$GenderEnumMap[instance.gender]!,
      'email': instance.email,
      'addressBook': instance.addressBook,
    };

const _$GenderEnumMap = {
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
  Gender.BOTH: 'BOTH',
};
