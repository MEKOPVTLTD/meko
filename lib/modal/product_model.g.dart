// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String,
      json['name'] as String,
      json['price'] as String,
      json['searchTerm'] as String,
      $enumDecode(_$GenderEnumMap, json['serviceFor']),
      json['type'] as String,
      json['categoryId'] as String,
      json['subCategoryId'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'searchTerm': instance.searchTerm,
      'serviceFor': _$GenderEnumMap[instance.serviceFor]!,
      'type': instance.type,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
    };

const _$GenderEnumMap = {
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
  Gender.BOTH: 'BOTH',
};
