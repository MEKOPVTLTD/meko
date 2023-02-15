import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meko/controller/category_controller.dart';
import 'package:meko/modal/category_model.dart';
import 'package:meko/reusable_widgets/carausel.dart';
import 'package:meko/screens/consumer/consumer_drawer.dart';
import 'package:meko/screens/grid.dart';
import 'package:meko/screens/sub_category.dart';

class ConsumerHomeWidget extends StatefulWidget {
  @override
  ConsumerHomeWidgetState createState() => ConsumerHomeWidgetState();
}

class ConsumerHomeWidgetState extends State<ConsumerHomeWidget> {
  final categoryController = Get.put(CategoryController());

  bool isCategoryLoading = false;
  bool isCategoryLoaded = false;
  late List<CategoryModel> categories = [];

  @override
  void initState() {
    setState(() {
      isCategoryLoading = true;
      isCategoryLoaded = false;
    });

    categoryController.getCategories().then((value) {
      categories = value;
      setState(() {
        isCategoryLoading = false;
        isCategoryLoaded = true;
      });
    }).onError((error, stackTrace) {
      setState(() {
        isCategoryLoading = false;
        isCategoryLoaded = true;
      });
    });
  }

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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CarauselWidget(),
                const SizedBox(
                  height: 10,
                ),
                if (isCategoryLoaded && !isCategoryLoading) ...[
                  renderCatalog(context)
                ] else ...[
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                ]
              ],
            ),
          ),
        ));
  }

  void onSelect(BuildContext context, CategoryModel categoryModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SubCategory(products: categoryModel.subCategory!)));
  }

  Widget renderCatalog(BuildContext context) {
    final grids = GridWidget<CategoryModel>(
      items: categories,
      isScrollable: false,
      getName: (CategoryModel value) => value.name,
      getImageName: (CategoryModel value) => value.imageName,
      onSelect: (CategoryModel value) {
        onSelect(context, value);
      },
    );
    return grids;
  }
}
