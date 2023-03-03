// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String,
      json['name'] as String,
      json['price'] as int,
      json['searchTerm'] as String,
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
      'type': instance.type,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
    };
