import 'package:flutter/material.dart';
import 'package:meko/reusable_widgets/carausel.dart';
import 'package:meko/screens/grid.dart';

class HomeWidget extends StatefulWidget {
  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: CustomScrollView(
        slivers: render(context),
      ),
    ));
  }

  List<Widget> render(BuildContext context) {
    List<Widget> items = [];
    items.add(renderCarousel(context));
    items.add(renderCatalog(context));
    return items;
  }

  Widget renderCarousel(BuildContext context) {
    final lists = SliverList(
      delegate: SliverChildListDelegate(
        [
          CarauselWidget(),
        ],
      ),
    );
    return lists;
  }

  Widget renderCatalog(BuildContext context) {
    final grids = GridWidget();
    return grids;
  }

  Widget buildImage(String img, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey,
      child: Image.network(
        img,
        fit: BoxFit.cover,
      ),
    );
  }
}
