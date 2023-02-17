// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      json['name'] as String,
      json['imageName'] as String,
      json['id'] as String,
      json['index'] as int,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageName': instance.imageName,
      'index': instance.index,
    };
