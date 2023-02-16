import 'package:cloud_firestore/cloud_firestore.dart';

void saveData() {
  saveSearchTerm();
}

void saveSearchTerm() {

  // FirebaseFirestore.instance.collection('SearchTerm').snapshots().forEach((querySnapshot) {
  //   for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
  //      docSnapshot.reference.delete();
  //   }
  // })

  var collection = FirebaseFirestore.instance
      .collection("SearchTerm");

  print("-----------------------");

  var data = [
    {"name": "Haircut Layer (Front)".toLowerCase(), "productId": "2224"},
    {"name": "Haircut Chinese".toLowerCase(), "productId": "2225"},
    {"name": "Haircut Steps".toLowerCase(), "productId": "2226"},
    {"name": "Haircut Flicks".toLowerCase(), "productId": "2227"},
    {"name": "Haircut Blunt".toLowerCase(), "productId": "2228"},
    {"name": "Haircut Deep U".toLowerCase(), "productId": "2229"},
    {"name": "Haircut Round".toLowerCase(), "productId": "2230"},
    {"name": "Haircut Straight".toLowerCase(), "productId": "2231"},

    {"name": "Advance Hair Cut Volume Minimize Cut".toLowerCase(), "productId": "2232"},
    {"name": "Advance Hair Cut Split-end-cut".toLowerCase(), "productId": "2233"},
    {"name": "Advance Hair Cut Full Layer".toLowerCase(), "productId": "2234"},
    {"name": "Advance Hair Cut Steps Layer".toLowerCase(), "productId": "2235"},

    {"name": "Advance Hair services Rebounding".toLowerCase(), "productId": "2242"},
    {"name": "Advance Hair services Smoothing".toLowerCase(), "productId": "2243"},
    {"name": "Advance Hair services Straightening".toLowerCase(), "productId": "2244"},

    {"name": "Hair Colour Streaking".toLowerCase(), "productId": "2221"},
    {"name": "Hair Colour Root Touch up".toLowerCase(), "productId": "2222"},
    {"name": "Hair Colour Global".toLowerCase(), "productId": "2223"},

    {"name": "Hair Spa Raga".toLowerCase(), "productId": "2245"},
    {"name": "Hair Spa Wella".toLowerCase(), "productId": "2246"},
    {"name": "Hair Spa Matrix".toLowerCase(), "productId": "2247"},

    {"name": "Hair Styling Crimping".toLowerCase(), "productId": "2236"},
    {"name": "Hair Styling Tonging".toLowerCase(), "productId": "2237"},
    {"name": "Hair Styling Blow Dry".toLowerCase(), "productId": "2238"},
    {"name": "Hair Styling Hot Roller".toLowerCase(), "productId": "2239"},
    {"name": "Hair Styling Ironing".toLowerCase(), "productId": "2240"},
    {"name": "Hair Styling Various Braiding".toLowerCase(), "productId": "2241"},

    {"name": "Hair Treatment Shampoo & Conditioning".toLowerCase(), "productId": "2248"},
    {"name": "Hair Treatment Oil Massage".toLowerCase(), "productId": "2249"},
    {"name": "Hair Treatment Hairfall Treatment".toLowerCase(), "productId": "2250"},
    {"name": "Hair Treatment Dandruff Treatment".toLowerCase(), "productId": "2251"},
  ];
  data.forEach((element) async{
    await collection.add(element);
  });
}
