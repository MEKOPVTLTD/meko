import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';

class CorousalWidget extends StatefulWidget {
  @override
  _CorousalWidgetState createState() => _CorousalWidgetState();
}

class _CorousalWidgetState extends State<CorousalWidget> {
  int activeIndex = 0;

  var arrayColours = [
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.orange,
    Colors.amber,
  ];



  final imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 15,),
        CarouselSlider.builder(
          options: CarouselOptions(
              height: 300,
              autoPlay: true,
              initialPage: 0,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enableInfiniteScroll: false,
              padEnds: false,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              }
          ),
          itemCount: imgList.length,
          itemBuilder: (context, index, realIndex) {
            final img = imgList[index];
            return buildImage(img, index);
          },
        ),
        SizedBox(height: 10,),
        CarouselIndicator(
          count: imgList.length,
          index: activeIndex,
          color: Colors.black12,
          activeColor: Colors.black,
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget buildImage(String img, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: loadImageFromNetwork(img),
    );
  }
}