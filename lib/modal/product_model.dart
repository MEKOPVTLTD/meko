import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meko/modal/gender.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';
@JsonSerializable()
class ProductModel {
  final String name;
  final String imageName;
  final Gender serviceFor;
  final int index;

  ProductModel(this.name, this.imageName, this.serviceFor, this.index);

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);



}