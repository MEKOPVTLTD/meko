import 'package:get/get.dart';
import 'package:meko/modal/category_model.dart';
import 'package:meko/repository/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepo = Get.put(CategoryRepository());

  Future<List<CategoryModel>> getCategories() async {
    return await _categoryRepo.allCategory();
  }
}
