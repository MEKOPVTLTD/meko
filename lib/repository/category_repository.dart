import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meko/modal/category_model.dart';

class CategoryRepository extends GetxService {
  static CategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> allCategory() async {
    final snapshot = await _db.collection("Category").get();
    final categories =
        snapshot.docs.map((e) => CategoryModel.fromJson(e.data(), e.id)).toList();
    return categories;
  }
}
