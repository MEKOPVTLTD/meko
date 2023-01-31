// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['name'] as String,
      json['imageName'] as String,
      $enumDecode(_$GenderEnumMap, json['serviceFor']),
      json['index'] as int,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageName': instance.imageName,
      'serviceFor': _$GenderEnumMap[instance.serviceFor]!,
      'index': instance.index,
    };

const _$GenderEnumMap = {
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
  Gender.BOTH: 'BOTH',
};
