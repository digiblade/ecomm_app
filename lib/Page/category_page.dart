import 'package:ecommerce/Components/Sections/card_section.dart';
import 'package:ecommerce/Models/category_model.dart';
import 'package:ecommerce/Models/drawer_page.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/Models/section_model.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryProductPage extends StatefulWidget {
  CategoryModel? cat;
  CategoryProductPage({super.key, this.cat});

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  String categoryId = "";
  List<ProductModel> productList = [];
  bool isLoading = true;
  getcategoryData(catId) async {
    List<ProductModel> prodList = await getAllProductByCategory(catId);
    setState(() {
      productList = prodList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getcategoryData(widget.cat!.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
      ),
      drawer: const DrawerPage(),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Center(
                  child: CircularProgressIndicator(color: secondary),
                ),
              ),
            if (!isLoading)
              CardSection(
                isProduct: true,
                items: productList,
                sectionTitle: "",
              ),
          ],
        ),
      ),
    );
  }
}
