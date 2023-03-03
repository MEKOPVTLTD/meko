import 'package:cloud_firestore/cloud_firestore.dart';

void saveData() async {



  // await clearSearchData('Category');
  // await clearSearchData('SubCategory');
  // await clearSearchData('Products');
  // saveSearchData();
}

void saveSearchData() {

  var categories = [
    {
      "imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/bridle_groom.png?alt=media&token=ba0ce169-7a95-48ed-aa63-ff47a65e2609",
      "index": 1,
      "name": 'Bridle & Groom',
      "subCategory": []
    },
    {
      "imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/salon_parlor.png?alt=media&token=78b589ec-2852-4080-ac6a-26f716d398bd",
      "index": 2,
      "name": 'Salon/Parlor',
      "subCategory": [
        {
          "imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/hair.png?alt=media&token=2682e24a-b97e-4bc4-8676-815be663ae00",
          "index": 1,
          "name": "Hair",
          "serviceFor": "MALE",
          "products": [
            {"type": "Haircut", "price": 120, "name": "Layer (Front)"},
            {"type": "Haircut", "price": 130, "name": "Chinese"},
            {"type": "Haircut", "price": 190, "name": "Steps"},
            {"type": "Haircut", "price": 140, "name": "Flicks"},
            {"type": "Haircut", "price": 190, "name": "Blunt"},
            {"type": "Haircut", "price": 120, "name": "Deep U"},
            {"type": "Haircut", "price": 126, "name": "Round"},
            {"type": "Haircut", "price": 129, "name": "Straight"},

            {"type": "Advance Hair Cut", "price": 120, "name": "Volume Minimize Cut"},
            {"type": "Advance Hair Cut", "price": 130, "name": "Split-end-cut"},
            {"type": "Advance Hair Cut", "price": 190, "name": "Full Layer"},
            {"type": "Advance Hair Cut", "price": 140, "name": "Steps Layer"},

            {"type": "Advance Hair services", "price": 200, "name": "Rebounding"},
            {"type": "Advance Hair services", "price": 230, "name": "Smoothing"},
            {"type": "Advance Hair services", "price": 220, "name": "Straightening"},

            {"type": "Hair Colour", "price": 220, "name": "Streaking"},
            {"type": "Hair Colour", "price": 220, "name": "Root Touch up"},
            {"type": "Hair Colour", "price": 220, "name": "Global"},

            {"type": "Hair Spa", "price": 324, "name": "Raga"},
            {"type": "Hair Spa", "price": 666, "name": "Wella"},
            {"type": "Hair Spa", "price": 265, "name": "Matrix"},

            {"type": "Hair Styling", "price": 119, "name": "Crimping"},
            {"type": "Hair Styling", "price": 268, "name": "Tonging"},
            {"type": "Hair Styling", "price": 352, "name": "Blow Dry"},
            {"type": "Hair Styling", "price": 396, "name": "Hot Roller"},
            {"type": "Hair Styling", "price": 430, "name": "Ironing"},

            {"type": "Hair Treatment", "price": 320, "name": "Shampoo & Conditioning"},
            {"type": "Hair Treatment", "price": 240, "name": "Oil Massage"},
            {"type": "Hair Treatment", "price": 400, "name": "Hairfall Treatment"},
            {"type": "Hair Treatment", "price": 410, "name": "Dandruff Treatment"},
          ]
        },
        {
          "imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/hair.png?alt=media&token=2682e24a-b97e-4bc4-8676-815be663ae00",
          "index": 2,
          "name": "Hair",
          "serviceFor": "FEMALE",
          "products": [
            {"type": "Haircut", "price": 120, "name": "Layer (Front)"},
            {"type": "Haircut", "price": 130, "name": "Chinese"},
            {"type": "Haircut", "price": 190, "name": "Steps"},
            {"type": "Haircut", "price": 140, "name": "Flicks"},
            {"type": "Haircut", "price": 190, "name": "Blunt"},
            {"type": "Haircut", "price": 120, "name": "Deep U"},
            {"type": "Haircut", "price": 126, "name": "Round"},
            {"type": "Haircut", "price": 129, "name": "Straight"},

            {"type": "Advance Hair Cut", "price": 120, "name": "Volume Minimize Cut"},
            {"type": "Advance Hair Cut", "price": 130, "name": "Split-end-cut"},
            {"type": "Advance Hair Cut", "price": 190, "name": "Full Layer"},
            {"type": "Advance Hair Cut", "price": 140, "name": "Steps Layer"},

            {"type": "Advance Hair services", "price": 200, "name": "Rebounding"},
            {"type": "Advance Hair services", "price": 230, "name": "Smoothing"},
            {"type": "Advance Hair services", "price": 220, "name": "Straightening"},

            {"type": "Hair Colour", "price": 220, "name": "Streaking"},
            {"type": "Hair Colour", "price": 220, "name": "Root Touch up"},
            {"type": "Hair Colour", "price": 220, "name": "Global"},

            {"type": "Hair Spa", "price": 324, "name": "Raga"},
            {"type": "Hair Spa", "price": 666, "name": "Wella"},
            {"type": "Hair Spa", "price": 265, "name": "Matrix"},

            {"type": "Hair Styling", "price": 119, "name": "Crimping"},
            {"type": "Hair Styling", "price": 268, "name": "Tonging"},
            {"type": "Hair Styling", "price": 352, "name": "Blow Dry"},
            {"type": "Hair Styling", "price": 396, "name": "Hot Roller"},
            {"type": "Hair Styling", "price": 430, "name": "Ironing"},

            {"type": "Hair Treatment", "price": 320, "name": "Shampoo & Conditioning"},
            {"type": "Hair Treatment", "price": 240, "name": "Oil Massage"},
            {"type": "Hair Treatment", "price": 400, "name": "Hairfall Treatment"},
            {"type": "Hair Treatment", "price": 410, "name": "Dandruff Treatment"},
          ]
        },
        {
          "imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/make-up.png?alt=media&token=3c8a373d-7f7c-49e9-8c80-52cf46a8a5e7",
          "index": 3,
          "name": "Makeup",
          "serviceFor": "FEMALE",
          "products": [
            {"type": "Facial", "price": 600, "name": "Herbal"},
            {"type": "Facial", "price": 590, "name": "Sehnaz"},
            {"type": "Face Massage", "price": 500, "name": "Herbal"}
          ]
        }
      ]
    },
    {"imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/yoga.png?alt=media&token=f58b8275-2781-4f72-a946-ff45bf780bcb", "index": 3, "name": 'Yoga trainer', "subCategory": []},
    {"imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/tailor.png?alt=media&token=a161ad0b-1444-45b0-9c9d-17f17d64741a", "index": 4, "name": 'Tailor', "subCategory": []},
    {"imageName": "https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/physio.png?alt=media&token=ec88af67-db7c-4c50-a695-97f306042459", "index": 5, "name": 'Physiotherapist', "subCategory": []},
  ];

  var categoryCollection = FirebaseFirestore.instance.collection("Category");
  var subCategoryCollection = FirebaseFirestore.instance.collection("SubCategory");
  var productCollection = FirebaseFirestore.instance.collection("Products");

  categories.forEach((category) async {
    var categoryRef = await categoryCollection.add({
      "name": category['name'],
      "index": category['index'],
      "imageName": category['imageName']
    });
    List subCategories = category['subCategory'] as List;
    subCategories.forEach( (subcategory) async{
      var subCategoryRef = await subCategoryCollection.add({
        "name": subcategory['name'],
        "index": subcategory['index'],
        "imageName": subcategory['imageName'],
        "serviceFor": subcategory['serviceFor'],
        "categoryId": categoryRef.id
      });
      List products = subcategory["products"] as List;
      products.forEach((product) async{
        await productCollection.add({
          "type": product['type'],
          "price": product['price'],
          "name": product['name'],
          "searchTerm": "${product['type']} ${product['name']} for ${subcategory['serviceFor']}".toLowerCase(),
          "subCategoryId": subCategoryRef.id,
          "categoryId": categoryRef.id,
        });
      });
    });
  });
}

Future clearSearchData(String collectionName) {
  return FirebaseFirestore.instance
      .collection(collectionName)
      .snapshots()
      .forEach((querySnapshot) {
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      docSnapshot.reference.delete();
    }
  });
}
