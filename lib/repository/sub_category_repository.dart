import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:meko/modal/sub_category_model.dart';

class SubCategoryRepository extends GetxService {
  static SubCategoryRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<SubCategoryModel>> allSubCategory(String categoryId) async {
    final snapshot = await _db
        .collection("SubCategory")
        .where("categoryId", isEqualTo: categoryId)
        .get();
    final categories = snapshot.docs
        .map((e) => SubCategoryModel.fromJson(e.data(), e.id))
        .toList();
    return categories;
  }
}
