import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/image_controller.dart';
import 'package:meko/reusable_widgets/reusable_widget.dart';

class CarauselWidget extends StatefulWidget {
  @override
  _CarauselWidgetState createState() => _CarauselWidgetState();
}

class _CarauselWidgetState extends State<CarauselWidget> {
  int activeIndex = 0;
  ImageController imageController = Get.put(ImageController());

  var arrayColours = [
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.orange,
    Colors.amber,
  ];



  final imgList = [
    'https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/carousel1.png?alt=media&token=472f5ff3-188b-48f2-bdc9-579299e96a17',
    'https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/carausel2.png?alt=media&token=135d69c3-71ae-4473-a6ea-d92d2aab84a0',
    'https://firebasestorage.googleapis.com/v0/b/meko-5251d.appspot.com/o/carausel3.png?alt=media&token=207822f0-f476-427f-983e-c3cd98a58868',
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