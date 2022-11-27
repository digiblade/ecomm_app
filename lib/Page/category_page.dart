import 'package:ecommerce/Components/Sections/card_section.dart';
import 'package:ecommerce/Models/CategoryModel.dart';
import 'package:ecommerce/Models/DrawerPage.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:ecommerce/Models/SectionModel.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

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
              const Center(
                child: CircularProgressIndicator(color: primary),
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
