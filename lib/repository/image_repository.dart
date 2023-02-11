import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

Reference get firebaseStorage => FirebaseStorage.instance.ref();

class ImageRepository extends GetxService {

  Future<String?> getImage(String? imageName) async{
    if( imageName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage.child(imageName);
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } catch (e) {
      return null;
    }

  }
}