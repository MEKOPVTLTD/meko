import 'package:flutter/material.dart';

import 'GridBuilder.dart';

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {

  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: 10,
        itemBuilder: (BuildContext ctx, index) {
          return GridTile(
            key: ValueKey(index),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(
                "xyz",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("abc"),
              trailing: const Icon(Icons.shopping_cart),
            ),
            child: Image.network(
              'https://www.kindacode.com/wp-content/uploads/2021/12/sample-leaf.jpeg',
              fit: BoxFit.cover,
            ),
          );
        });

  }
}