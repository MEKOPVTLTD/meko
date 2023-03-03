import 'package:json_annotation/json_annotation.dart';
import 'package:meko/modal/gender.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final int price;
  final String searchTerm;
  final String type;
  final String categoryId;
  final String subCategoryId;

  ProductModel(
      this.id,
      this.name,
      this.price,
      this.searchTerm,
      this.type,
      this.categoryId,
      this.subCategoryId,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json, String id) =>
      _$ProductModelFromJson({...json, "id": id});
}
