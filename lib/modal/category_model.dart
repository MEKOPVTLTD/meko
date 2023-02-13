import 'package:meko/modal/sub_category_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String name;
  final String imageName;
  final List<SubCategoryModel>? subCategory;
  final int index;

  CategoryModel(this.name, this.imageName, this.subCategory, this.index);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
