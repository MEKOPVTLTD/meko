import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/category_controller.dart';
import 'package:meko/controller/image_controller.dart';
import 'package:meko/modal/category_model.dart';
import 'package:meko/modal/sub_category_model.dart';
import 'package:meko/screens/sub_category.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key}) : super(key: key);

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return FutureBuilder(
        future: categoryController.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<CategoryModel> categoryModel =
                  snapshot.data as List<CategoryModel>;
              return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 3 / 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return GridTile(
                          key: ValueKey(index),
                          footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: Text(
                                categoryModel[index].name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          child: InkResponse(
                              enableFeedback: true,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black54),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black54,
                                          spreadRadius: 2),
                                    ]
                                    // color: hexStringToColor("EEEEEE")
                                    ),
                                child: loadImage(categoryModel, index),
                              ),
                              onTap: () => _onTileClicked(
                                  categoryModel[index].subCategory)));
                    },
                    childCount: categoryModel.length,
                  ));
            } else {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Center(child: Text("Something went wrong")),
                  ],
                ),
              );
            }
          } else {
            return SliverList(
              delegate: SliverChildListDelegate(
                [
                  const CircularProgressIndicator(),
                ],
              ),
            );
          }
        });
  }

  Widget loadImage(List<CategoryModel> categoryModel, int index) {
    ImageController imageController = Get.put(ImageController());
    return FutureBuilder(
        future: imageController.getImage(categoryModel[index].imageName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Image.network(
                color: Colors.black, snapshot.data!.toString());
          }
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  void _onTileClicked(List<SubCategoryModel>? products) {
    List<SubCategoryModel> formattedProducts;
    if (products == null) {
      formattedProducts = [];
    } else {
      formattedProducts = products;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubCategory(products: formattedProducts)));
  }
}
