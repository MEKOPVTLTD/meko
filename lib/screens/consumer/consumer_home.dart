import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/category_controller.dart';
import 'package:meko/modal/category_model.dart';
import 'package:meko/reusable_widgets/carausel.dart';
import 'package:meko/screens/consumer/consumer_drawer.dart';
import 'package:meko/screens/grid.dart';
import 'package:meko/screens/sub_category.dart';

class ConsumerHomeWidget extends StatefulWidget {
  @override
  ConsumerHomeWidgetState createState() => ConsumerHomeWidgetState();
}

class ConsumerHomeWidgetState extends State<ConsumerHomeWidget> {
  final categoryController = Get.put(CategoryController());
  bool isSearching = false;

  String searchValue = '';

  bool isCategoryLoading = false;
  bool isCategoryLoaded = false;
  late List<CategoryModel> categories = [];

  @override
  void initState() {
    setState(() {
      isCategoryLoading = true;
      isCategoryLoaded = false;
    });

    categoryController.getCategories().then((value) {
      categories = value;
      setState(() {
        isCategoryLoading = false;
        isCategoryLoaded = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        isCategoryLoading = false;
        isCategoryLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: !isSearching,
        title: Card(
          child: isSearching
              ? TextField(
                  decoration: InputDecoration(
                      icon: IconButton(
                          onPressed: () => {
                                setState(() {
                                  isSearching = false;
                                  searchValue = '';
                                })
                              },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          )),
                      hintText: "Search for service..."),
                  onChanged: (val) {
                    setState(() {
                      searchValue = val;
                    });
                  },
                )
              : Text("kjbkfb"),
        ),
        actions: isSearching
            ? []
            : [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                        searchValue = '';
                      });
                    },
                    icon: Icon(
                      Icons.search,
                    ))
              ],
      ),

      drawer: isSearching ? null : ConsumerDrawer(),
      body: searchValue.isEmpty
          ? render(context)
          : StreamBuilder<QuerySnapshot>(
              stream: getProductsBasedOnSearchedString(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;

                          return ListTile(title: Text(data['name']));
                        });
              },
            ),
      // body: render(context)
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>
      getProductsBasedOnSearchedString() {
    return FirebaseFirestore.instance
        .collection("SearchTerm")
        .where("name",
            isGreaterThanOrEqualTo: searchValue,
            isLessThan: searchValue.substring(0, searchValue.length - 1) +
                String.fromCharCode(
                    searchValue.codeUnitAt(searchValue.length - 1) + 1))
        .snapshots();
  }

  SingleChildScrollView render(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CarauselWidget(),
            const SizedBox(
              height: 10,
            ),
            if (isCategoryLoaded && !isCategoryLoading) ...[
              renderCatalog(context)
            ] else ...[
              const Center(
                child: CircularProgressIndicator(),
              )
            ]
          ],
        ),
      ),
    );
  }

  void onSelect(BuildContext context, CategoryModel categoryModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SubCategory(products: categoryModel.subCategory!)));
  }

  Widget renderCatalog(BuildContext context) {
    final grids = GridWidget<CategoryModel>(
      items: categories,
      isScrollable: false,
      getName: (CategoryModel value) => value.name,
      getImageName: (CategoryModel value) => value.imageName,
      onSelect: (CategoryModel value) {
        onSelect(context, value);
      },
    );
    return grids;
  }
}
