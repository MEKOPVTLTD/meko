import 'package:cloud_firestore/cloud_firestore.dart';
class CategoryModel {
  final String name;
  final String imageName;
  final int index;

  CategoryModel(this.name, this.imageName, this.index);

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return CategoryModel(data["name"], data["imageName"], data["index"]);
  }

}