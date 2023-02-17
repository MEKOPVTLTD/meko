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
      "imageName": "bridle_groom.png",
      "index": 1,
      "name": 'Bridle & Groom',
      "subCategory": []
    },
    {
      "imageName": "salon_parlor.png",
      "index": 2,
      "name": 'Salon/Parlor',
      "subCategory": [
        {
          "imageName": "hair.png",
          "index": 1,
          "name": "Hair",
          "serviceFor": "MALE",
          "products": [
            {"type": "Haircut", "price": "120", "serviceFor": "MALE", "name": "Layer (Front)"},
            {"type": "Haircut", "price": "130", "serviceFor": "MALE", "name": "Chinese"},
            {"type": "Haircut", "price": "190", "serviceFor": "MALE", "name": "Steps"},
            {"type": "Haircut", "price": "140", "serviceFor": "MALE", "name": "Flicks"},
            {"type": "Haircut", "price": "190", "serviceFor": "MALE", "name": "Blunt"},
            {"type": "Haircut", "price": "120", "serviceFor": "MALE", "name": "Deep U"},
            {"type": "Haircut", "price": "126", "serviceFor": "MALE", "name": "Round"},
            {"type": "Haircut", "price": "129", "serviceFor": "MALE", "name": "Straight"},

            {"type": "Advance Hair Cut", "price": "120", "serviceFor": "MALE", "name": "Volume Minimize Cut"},
            {"type": "Advance Hair Cut", "price": "130", "serviceFor": "MALE", "name": "Split-end-cut"},
            {"type": "Advance Hair Cut", "price": "190", "serviceFor": "MALE", "name": "Full Layer"},
            {"type": "Advance Hair Cut", "price": "140", "serviceFor": "MALE", "name": "Steps Layer"},

            {"type": "Advance Hair services", "price": "200", "serviceFor": "MALE", "name": "Rebounding"},
            {"type": "Advance Hair services", "price": "230", "serviceFor": "MALE", "name": "Smoothing"},
            {"type": "Advance Hair services", "price": "220", "serviceFor": "MALE", "name": "Straightening"},

            {"type": "Hair Colour", "price": "220", "serviceFor": "MALE", "name": "Streaking"},
            {"type": "Hair Colour", "price": "220", "serviceFor": "MALE", "name": "Root Touch up"},
            {"type": "Hair Colour", "price": "220", "serviceFor": "MALE", "name": "Global"},

            {"type": "Hair Spa", "price": "324", "serviceFor": "MALE", "name": "Raga"},
            {"type": "Hair Spa", "price": "666", "serviceFor": "MALE", "name": "Wella"},
            {"type": "Hair Spa", "price": "265", "serviceFor": "MALE", "name": "Matrix"},

            {"type": "Hair Styling", "price": "119", "serviceFor": "MALE", "name": "Crimping"},
            {"type": "Hair Styling", "price": "268", "serviceFor": "MALE", "name": "Tonging"},
            {"type": "Hair Styling", "price": "352", "serviceFor": "MALE", "name": "Blow Dry"},
            {"type": "Hair Styling", "price": "396", "serviceFor": "MALE", "name": "Hot Roller"},
            {"type": "Hair Styling", "price": "430", "serviceFor": "MALE", "name": "Ironing"},

            {"type": "Hair Treatment", "price": "320", "serviceFor": "MALE", "name": "Shampoo & Conditioning"},
            {"type": "Hair Treatment", "price": "240", "serviceFor": "MALE", "name": "Oil Massage"},
            {"type": "Hair Treatment", "price": "400", "serviceFor": "MALE", "name": "Hairfall Treatment"},
            {"type": "Hair Treatment", "price": "410", "serviceFor": "MALE", "name": "Dandruff Treatment"},
          ]
        },
        {
          "imageName": "hair.png",
          "index": 2,
          "name": "Hair",
          "serviceFor": "FEMALE",
          "products": [
            {"type": "Haircut", "price": "120", "serviceFor": "FEMALE", "name": "Layer (Front)"},
            {"type": "Haircut", "price": "130", "serviceFor": "FEMALE", "name": "Chinese"},
            {"type": "Haircut", "price": "190", "serviceFor": "FEMALE", "name": "Steps"},
            {"type": "Haircut", "price": "140", "serviceFor": "FEMALE", "name": "Flicks"},
            {"type": "Haircut", "price": "190", "serviceFor": "FEMALE", "name": "Blunt"},
            {"type": "Haircut", "price": "120", "serviceFor": "FEMALE", "name": "Deep U"},
            {"type": "Haircut", "price": "126", "serviceFor": "FEMALE", "name": "Round"},
            {"type": "Haircut", "price": "129", "serviceFor": "FEMALE", "name": "Straight"},

            {"type": "Advance Hair Cut", "price": "120", "serviceFor": "FEMALE", "name": "Volume Minimize Cut"},
            {"type": "Advance Hair Cut", "price": "130", "serviceFor": "FEMALE", "name": "Split-end-cut"},
            {"type": "Advance Hair Cut", "price": "190", "serviceFor": "FEMALE", "name": "Full Layer"},
            {"type": "Advance Hair Cut", "price": "140", "serviceFor": "FEMALE", "name": "Steps Layer"},

            {"type": "Advance Hair services", "price": "200", "serviceFor": "FEMALE", "name": "Rebounding"},
            {"type": "Advance Hair services", "price": "230", "serviceFor": "FEMALE", "name": "Smoothing"},
            {"type": "Advance Hair services", "price": "220", "serviceFor": "FEMALE", "name": "Straightening"},

            {"type": "Hair Colour", "price": "220", "serviceFor": "FEMALE", "name": "Streaking"},
            {"type": "Hair Colour", "price": "220", "serviceFor": "FEMALE", "name": "Root Touch up"},
            {"type": "Hair Colour", "price": "220", "serviceFor": "FEMALE", "name": "Global"},

            {"type": "Hair Spa", "price": "324", "serviceFor": "FEMALE", "name": "Raga"},
            {"type": "Hair Spa", "price": "666", "serviceFor": "FEMALE", "name": "Wella"},
            {"type": "Hair Spa", "price": "265", "serviceFor": "FEMALE", "name": "Matrix"},

            {"type": "Hair Styling", "price": "119", "serviceFor": "FEMALE", "name": "Crimping"},
            {"type": "Hair Styling", "price": "268", "serviceFor": "FEMALE", "name": "Tonging"},
            {"type": "Hair Styling", "price": "352", "serviceFor": "FEMALE", "name": "Blow Dry"},
            {"type": "Hair Styling", "price": "396", "serviceFor": "FEMALE", "name": "Hot Roller"},
            {"type": "Hair Styling", "price": "430", "serviceFor": "FEMALE", "name": "Ironing"},

            {"type": "Hair Treatment", "price": "320", "serviceFor": "FEMALE", "name": "Shampoo & Conditioning"},
            {"type": "Hair Treatment", "price": "240", "serviceFor": "FEMALE", "name": "Oil Massage"},
            {"type": "Hair Treatment", "price": "400", "serviceFor": "FEMALE", "name": "Hairfall Treatment"},
            {"type": "Hair Treatment", "price": "410", "serviceFor": "FEMALE", "name": "Dandruff Treatment"},
          ]
        },
        {
          "imageName": "make-up.png",
          "index": 3,
          "name": "Makeup",
          "serviceFor": "FEMALE",
          "products": [
            {"type": "Facial", "price": "600", "serviceFor": "FEMALE", "name": "Herbal"},
            {"type": "Facial", "price": "590", "serviceFor": "FEMALE", "name": "Sehnaz"},
            {"type": "Face Massage", "price": "500", "serviceFor": "FEMALE", "name": "Herbal"}
          ]
        }
      ]
    },
    {"imageName": "yoga.png", "index": 3, "name": 'Yoga trainer', "subCategory": []},
    {"imageName": "tailor.png", "index": 4, "name": 'Tailor', "subCategory": []},
    {"imageName": "physio.png", "index": 5, "name": 'Physiotherapist', "subCategory": []},
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
          "serviceFor": product['serviceFor'],
          "name": product['name'],
          "searchTerm": "${product['type']} ${product['name']} for ${product['serviceFor']}".toLowerCase(),
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
