// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['name'] as String,
      json['imageName'] as String,
      (json['subCategory'] as List<dynamic>?)
          ?.map((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['index'] as int,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'imageName': instance.imageName,
      'subCategory': instance.subCategory,
      'index': instance.index,
    };
