import 'package:get/get.dart';
import 'package:meko/modal/category_model.dart';
import 'package:meko/modal/sub_category_model.dart';
import 'package:meko/repository/category_repository.dart';
import 'package:meko/repository/sub_category_repository.dart';

class SubCategoryController extends GetxController {
  static SubCategoryController get instance => Get.find();

  final _categoryRepo = Get.put(SubCategoryRepository());

  Future<List<SubCategoryModel>> getSubCategories(String categoryId) async {
    return await _categoryRepo.allSubCategory(categoryId);
  }
}
