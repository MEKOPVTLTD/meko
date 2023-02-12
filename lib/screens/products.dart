import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/image_controller.dart';
import 'package:meko/modal/product_model.dart';

class Products extends StatefulWidget {
  final List<ProductModel> products;

  const Products({super.key, required this.products});

  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products> with TickerProviderStateMixin {
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
                      widget.products[index].name,
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
                            BoxShadow(color: Colors.black54, spreadRadius: 2),
                          ]
                          // color: hexStringToColor("EEEEEE")
                          ),
                      child: loadImage(widget.products, index),
                    ),
                    onTap: () => _onTileClicked(index)));
          },
          childCount: widget.products.length,
        ));
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

  Widget loadImage(List<ProductModel> categoryModel, int index) {
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

  void _onTileClicked(int i) {
    print(i);
  }
}
