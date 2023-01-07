import 'package:flutter/material.dart';

import 'HomePageState.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}
