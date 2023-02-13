import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/image_controller.dart';
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
          title: Text("Meko"),
        ),
        body: Container(
            child: CustomScrollView(
          slivers: render(context),
        )));
  }

  List<Widget> render(BuildContext context) {
    List<Widget> items = [];
    items.add(renderTab(context));
    if (widget.products.isEmpty) {
      items.add(renderNoContentMessage(context));
    } else {
      items.add(renderTabView(context));
    }

    return items;
  }

  Widget renderTab(BuildContext context) {
    final lists = SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
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
          )
        ],
      ),
    );
    return lists;
  }

  Widget renderTabView(BuildContext context) {
    return GridWidget<SubCategoryModel>(
      items: widget.products,
      getName: (SubCategoryModel value) => value.name,
      getImageName: (SubCategoryModel value) => value.imageName,
      onSelect: (SubCategoryModel value) {
        _onTileClicked(context, value);
      },
    );
  }

  Widget renderNoContentMessage(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const Center(
            child: Text("No Product"),
          ),
        ],
      ),
    );
  }

  Widget loadImage(List<SubCategoryModel> categoryModel, int index) {
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

  void _onTileClicked(BuildContext context, SubCategoryModel i) {
    // print(i);
  }
}
