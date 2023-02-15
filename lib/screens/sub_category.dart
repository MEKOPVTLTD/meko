import 'package:flutter/material.dart';
import 'package:meko/modal/gender.dart';
import 'package:meko/modal/sub_category_model.dart';
import 'package:meko/screens/grid.dart';

class SubCategory extends StatefulWidget {
  final List<SubCategoryModel> products;

  const SubCategory({super.key, required this.products});

  @override
  SubCategoryState createState() => SubCategoryState();
}

class SubCategoryState extends State<SubCategory>
    with TickerProviderStateMixin {
  late TabController _tabController;

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
          title: const Text('Example'),
        ),
        body: Column(
          children: [renderTab(context), renderTabView(context)],
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

  Widget renderTabView(BuildContext context) {
    return Expanded(
        child: TabBarView(
      controller: _tabController,
      children: [
        GridWidget<SubCategoryModel>(
          padding: 10.0,
          items: widget.products
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
          items: widget.products
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

  void _onTileClicked(BuildContext context, SubCategoryModel i) {
    // print(i);
  }
}
