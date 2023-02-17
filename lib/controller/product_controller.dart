import 'package:get/get.dart';
import 'package:meko/modal/product_model.dart';
import 'package:meko/repository/product_repository.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _productRepo = Get.put(ProductRepository());

  Future<List<ProductModel>> getProducts(String subCategoryId) async {
    return await _productRepo.allProduct(subCategoryId);
  }
}
