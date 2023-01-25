import 'package:flutter/material.dart';


class GridBuilder extends StatefulWidget {

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {}

  final List<Map> catalogServices = [
    {
      "id" : 1,
      "name": "Haircut",
      "asset": "assets/haircut.png",
      "price": "Rs 100"
    },
    {
      "id" : 2,
      "name": "Manicure",
      "asset": "assets/manicure.png",
      "price": "Rs 100"
    },
    {
      "id" : 3,
      "name": "Home cleaning",
      "asset": "assets/home_cleaning.png",
      "price": "Rs 100"
    },
    {
      "id" : 4,
      "name": "Bath cleaning",
      "asset": "assets/bathroom_cleaning.png",
      "price": "Rs 100"
    },
    {
      "id" : 5,
      "name": "Mehandi",
      "asset": "assets/mehandi.png",
      "price": "Rs 100"
    },
    {
      "id" : 6,
      "name": "Facial",
      "asset": "assets/facial.png",
      "price": "Rs 100"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  catalogServices[index]['price']
              ),
              trailing: const Icon(Icons.shopping_cart),
            ),
            child: Image(
                image: AssetImage(catalogServices[index]['asset']), fit: BoxFit.cover),
          );
        });
  }
}