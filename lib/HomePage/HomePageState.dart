import 'package:flutter/material.dart';
import 'package:meko/GridView/GridBuilder.dart';

import 'HomePage.dart';

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
      body: GridBuilder(),

    );
  }

}