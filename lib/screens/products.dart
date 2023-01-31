import 'package:flutter/material.dart';
import 'package:meko/modal/product_model.dart';
import 'package:meko/utils/color_utils.dart';

class Products extends StatefulWidget {

  final List<ProductModel>? products;

  const Products({super.key, required this.products});

  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products> with
    TickerProviderStateMixin{
  late TabController _tabController;


  @override
  void initState() {
    _tabController = TabController(vsync: this,length: 2);
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
        child: Container(
          color: Colors.black12,
          child: TabBar(

            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,

            indicator:  const BoxDecoration(
                color: Colors.black
            ),

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
      ),
    );
  }

  void _onTileClicked(int i) {
    print(i);
  }
}