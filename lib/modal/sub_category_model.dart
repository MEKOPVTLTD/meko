import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meko/modal/gender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_category_model.g.dart';

@JsonSerializable()
class SubCategoryModel {
  final String name;
  final String imageName;
  final Gender serviceFor;
  final int index;

  SubCategoryModel(this.name, this.imageName, this.serviceFor, this.index);

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);
}
