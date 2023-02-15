import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/image_controller.dart';

class GridWidget<T> extends StatefulWidget {
  const GridWidget(
      {super.key,
      required this.items,
      required this.getName,
      required this.getImageName,
      required this.onSelect,
      this.padding = 0.0,
      required this.isScrollable});

  final List<T> items;
  final Function getName;
  final Function getImageName;
  final Function onSelect;
  final bool isScrollable;
  final double padding;

  @override
  State<GridWidget<T>> createState() => _GridWidgetState<T>();
}

class _GridWidgetState<T> extends State<GridWidget<T>> {
  @override
  Widget build(BuildContext context) {
    var items = widget.items;

    return GridView.count(
      padding: EdgeInsets.all(widget.padding),
      primary: false,
      physics: widget.isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      crossAxisCount: 3,
      childAspectRatio: 3 / 4,
      shrinkWrap: true,
      children: List<Widget>.generate(
          items.length, (index) => _buildItem(index, items[index])),
    );
  }

  Widget _buildItem(int index, T item) {
    return GridTile(
        key: ValueKey(index),
        footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              widget.getName(item).toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              child: loadImage(item),
            ),
            onTap: () => widget.onSelect(item)));
  }

  Widget loadImage(T categoryModel) {
    ImageController imageController = Get.put(ImageController());
    return FutureBuilder(
        future: imageController
            .getImage(widget.getImageName(categoryModel).toString()),
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
}
