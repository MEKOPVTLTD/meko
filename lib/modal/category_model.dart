import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final String id;
  final String name;
  final String imageName;
  final int index;

  CategoryModel(this.name, this.imageName, this.id, this.index);

  factory CategoryModel.fromJson(Map<String, dynamic> json, String id) {
   return _$CategoryModelFromJson({...json, "id": id});
  }
}
