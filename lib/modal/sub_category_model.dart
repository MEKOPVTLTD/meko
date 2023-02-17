import 'package:meko/modal/gender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_category_model.g.dart';

@JsonSerializable()
class SubCategoryModel {
  final String id;
  final String categoryId;
  final String name;
  final String imageName;
  final Gender serviceFor;
  final int index;


  SubCategoryModel(this.id, this.categoryId, this.name, this.imageName, this.serviceFor, this.index);

  factory SubCategoryModel.fromJson(Map<String, dynamic> json, String id) =>
      _$SubCategoryModelFromJson({...json, "id": id});
}
