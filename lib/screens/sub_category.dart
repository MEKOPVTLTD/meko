import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/sub_category_controller.dart';
import 'package:meko/modal/gender.dart';
import 'package:meko/modal/sub_category_model.dart';
import 'package:meko/screens/grid.dart';
import 'package:meko/screens/product_list.dart';

class SubCategory extends StatefulWidget {
  final String categoryId;

  const SubCategory({super.key, required this.categoryId});

  @override
  SubCategoryState createState() => SubCategoryState();
}

class SubCategoryState extends State<SubCategory>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final subCategoryController = Get.put(SubCategoryController());

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('Sub Categories'),
        ),
        body: Column(
          children: [renderTab(context),

            FutureBuilder(
                future: subCategoryController.getSubCategories(widget.categoryId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<SubCategoryModel> subCategories = snapshot.data as List<SubCategoryModel>;
                      return renderTabView(subCategories);
                    }
                    else {
                      Center(
                        child: Text("No Product Found"),
                      );
                    }
                  }
                return Center(
                  child: CircularProgressIndicator(),
                );
            })
            // renderTabView(context)
          ],
        ));
  }

  Widget renderTab(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: TabBar(
        unselectedLabelColor: Colors.black,
        labelColor: Colors.white,
        indicator: const BoxDecoration(color: Colors.black),
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            icon: Icon(Icons.man_outlined),
          ),
          Tab(
            icon: Icon(Icons.woman_outlined),
          )
        ],
      ),
    );
  }

  Widget renderTabView(List<SubCategoryModel> subCategories) {
    return Expanded(
        child: TabBarView(
      controller: _tabController,
      children: [
        GridWidget<SubCategoryModel>(
          padding: 10.0,
          items: subCategories
              .where((element) => element.serviceFor == Gender.MALE)
              .toList(),
          isScrollable: true,
          getName: (SubCategoryModel value) => value.name,
          getImageName: (SubCategoryModel value) => value.imageName,
          onSelect: (SubCategoryModel value) {
            _onTileClicked(context, value);
          },
        ),
        GridWidget<SubCategoryModel>(
          padding: 10.0,
          items: subCategories
              .where((element) => element.serviceFor == Gender.FEMALE)
              .toList(),
          isScrollable: true,
          getName: (SubCategoryModel value) => value.name,
          getImageName: (SubCategoryModel value) => value.imageName,
          onSelect: (SubCategoryModel value) {
            _onTileClicked(context, value);
          },
        )
      ],
    ));
  }

  void _onTileClicked(BuildContext context, SubCategoryModel subCategoryModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProductList(productId: subCategoryModel.id)));
  }
}
