import 'package:get/get.dart';
import 'package:meko/modal/category_model.dart';
import 'package:meko/repository/category_repository.dart';
import 'package:meko/repository/image_repository.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  final _categoryRepo = Get.put(ImageRepository());

  Future<String?> getImage(String? imageName) async {
    return await _categoryRepo.getImage(imageName);
  }
}