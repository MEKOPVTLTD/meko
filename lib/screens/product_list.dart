import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  ProductList({super.key, required this.productId});

  String productId;
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
