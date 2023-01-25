import 'package:flutter/material.dart';
import 'package:meko/screens/products.dart';
import 'package:meko/utils/color_utils.dart';


class GridBuilder extends StatefulWidget {

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {}

  final List<Map> catalogServices = [
    {
      "id" : 1,
      "name": "Salon/Parlor",
      "asset": "assets/salon_parlor.png",
      "price": "Rs 100"
    },
    {
      "id" : 2,
      "name": "Bridle & Groom",
      "asset": "assets/bridle_groom.png",
      "price": "Rs 100"
    },
    {
      "id" : 3,
      "name": "Tailor",
      "asset": "assets/tailor.png",
      "price": "Rs 100"
    },
    {
      "id" : 4,
      "name": "Physiotherapist",
      "asset": "assets/physio.png",
      "price": "Rs 100"
    },
    {
      "id" : 5,
      "name": "Yoga trainer",
      "asset": "assets/yoga.png",
      "price": "Rs 100"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  void _onTileClicked(int i) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Products(index: i)));
  }
}