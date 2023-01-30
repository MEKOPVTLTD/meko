import 'package:flutter/material.dart';
import 'package:meko/screens/products.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({Key? key}) : super(key: key);

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  final List<Map> catalogServices = [
    {
      "id": 1,
      "name": "Salon/Parlor",
      "asset": "assets/salon_parlor.png",
      "price": "Rs 100"
    },
    {
      "id": 2,
      "name": "Bridle & Groom",
      "asset": "assets/bridle_groom.png",
      "price": "Rs 100"
    },
    {
      "id": 3,
      "name": "Tailor",
      "asset": "assets/tailor.png",
      "price": "Rs 100"
    },
    {
      "id": 4,
      "name": "Physiotherapist",
      "asset": "assets/physio.png",
      "price": "Rs 100"
    },
    {
      "id": 5,
      "name": "Yoga trainer",
      "asset": "assets/yoga.png",
      "price": "Rs 100"
    }
  ];

  @override
  Widget build(BuildContext context) {
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
                      catalogServices[index]['name'],
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
                      child: Image(
                          color: Colors.black,
                          image: AssetImage(catalogServices[index]['asset'])),
                    ),
                    onTap: () => _onTileClicked(index)));
          },
          childCount: catalogServices.length,
        ));
  }

  void _onTileClicked(int i) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Products(index: i)));
  }
}
