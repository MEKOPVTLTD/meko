import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/product_controller.dart';
import 'package:meko/modal/product_model.dart';
import "package:collection/collection.dart";
class ProductList extends StatefulWidget {
  ProductList({super.key, required this.productId});

  String productId;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('Sub Categories'),
        ),
        body: FutureBuilder(
            future: productController.getProducts(widget.productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var groupProdcuts = toGroupProdcuts(snapshot.data!);
                  return renderProducts(groupProdcuts);
                } else {
                  Center(
                    child: Text("No Product Found"),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Widget renderProducts(Map<String, List<ProductModel>> groupedProducts) {
    return ListView.builder(

      itemCount: groupedProducts.length,
      itemBuilder: (context, i) {
        return Container(
          child: ListTileTheme(
            tileColor: Colors.black,

            child: ExpansionTile(
              collapsedTextColor: Colors.white,
              collapsedIconColor: Colors.white,
              textColor: Colors.white,
              iconColor: Colors.white,
              initiallyExpanded: true,
              title: Text(

                groupedProducts.keys.elementAt(i),
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              children: <Widget>[
                Column(
                  children:
                  _buildExpandableContent(groupedProducts.values.elementAt(i)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildExpandableContent(List<ProductModel> productModel) {
    List<Widget> columnContent = [];

    productModel.forEach((element) {
      columnContent.add(ListTile(

        tileColor: Colors.white,
        title: Text(
          element.name,
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: Wrap(
          spacing: 0,
          children: [
            Icon(Icons.currency_rupee_outlined, color: Colors.black, ),
            Text(element.price, style: TextStyle(fontSize: 18.0),),
            SizedBox(width: 20),
            Icon(Icons.add_shopping_cart, color: Colors.black,),
          ],
        )
      ));
    });

    return columnContent;
  }

  Map<String, List<ProductModel>> toGroupProdcuts(List<ProductModel> products) {
    return groupBy(products, (value) => value.type);
  }
}
