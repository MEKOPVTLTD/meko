import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:meko/modal/category_model.dart';

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


  // Future<List<ImageModel>> allImage() async{
  //   final snapshot = await _db.collection("Image").get();
  //   final categories = snapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
  //   return categories;
  //
  // }
}