// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) =>
    SubCategoryModel(
      json['id'] as String,
      json['categoryId'] as String,
      json['name'] as String,
      json['imageName'] as String,
      $enumDecode(_$GenderEnumMap, json['serviceFor']),
      json['index'] as int,
    );

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
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
