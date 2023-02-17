import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meko/modal/product_model.dart';

class ProductRepository extends GetxService {
  static ProductRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<ProductModel>> allProduct(String subCategoryId) async {
    final snapshot = await _db
        .collection("Products")
        .where("subCategoryId", isEqualTo: subCategoryId)
        .get();
    final categories = snapshot.docs
        .map((e) => ProductModel.fromJson(e.data(), e.id))
        .toList();
    return categories;
  }

  Future<List<ProductModel>> allProductWithTypeGroup(String subCategoryId) async {
    final snapshot = await _db
        .collection("Products")
        .where("subCategoryId", isEqualTo: subCategoryId)
        .get();
    final categories = snapshot.docs
        .map((e) => ProductModel.fromJson(e.data(), e.id))
        .toList();
    return categories;
  }
}
