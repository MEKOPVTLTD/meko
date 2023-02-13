import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:meko/reusable_widgets/carausel.dart';
import 'package:meko/screens/consumer/consumer_drawer.dart';
import 'package:meko/screens/grid.dart';

class ConsumerHomeWidget extends StatefulWidget {
  @override
  ConsumerHomeWidgetState createState() => ConsumerHomeWidgetState();
}

class ConsumerHomeWidgetState extends State<ConsumerHomeWidget> {
  @override
  Widget build(BuildContext context) {
    String searchValue = '';
    final List<String> _suggestions = [
      'Afeganistan',
      'Albania',
      'Algeria',
      'Australia',
      'Brazil',
      'German',
      'Madagascar',
      'Mozambique',
      'Portugal',
      'Zambia'
    ];
    return Scaffold(
        appBar: EasySearchBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: const Text('Example'),
            onSearch: (value) => setState(() => searchValue = value),
            suggestions: _suggestions),
        drawer: const ConsumerDrawer(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
