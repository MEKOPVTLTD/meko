import 'package:flutter/material.dart';
import 'package:meko/utils/color_utils.dart';


class Products extends StatefulWidget {

  final int index;

  const Products({super.key, required this.index});

  @override
  ProductsState createState() => ProductsState();
}

class ProductsState extends State<Products> {
  void _toggle(int index) {}

  final List<Map> catalogServices = [
    {
      "id" : 1,
      "name": "Hair",
      "asset": "assets/hair.png",
      "price": "Rs 100"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meko"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: catalogServices.length,
            itemBuilder: (BuildContext ctx, index) {
              return GridTile(
                  key: ValueKey(index),
                  footer: GridTileBar(

                      backgroundColor: Colors.black54,
                      title: Text(
                        catalogServices[index]['name'],
                        style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      )
                  ),
                  child: InkResponse(
                      enableFeedback: true,
                      child: Container(
                        decoration: BoxDecoration(color: hexStringToColor("BEE3E6")),
                        child: Image(
                            color: Colors.black,
                            image: AssetImage(catalogServices[index]['asset'])
                        ),
                      ),
                      onTap: () => _onTileClicked(index)
                  )
              );
            }),
      ),
    );
  }

  void _onTileClicked(int i) {
    print(i);
  }
}