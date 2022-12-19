import 'package:ecommerce/Component2/Input/input_field.dart';
import 'package:ecommerce/Components/Sections/card_section.dart';
import 'package:ecommerce/Models/category_model.dart';
import 'package:ecommerce/Models/drawer_page.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/Models/section_model.dart';
import 'package:ecommerce/Util/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  CategoryModel? cat;
  SearchPage({super.key, this.cat});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String categoryId = "";
  List<ProductModel> productList = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  getcategoryData() async {
    List<ProductModel> prodList =
        await getAllProductBySearch(searchController.text);
    setState(() {
      productList = prodList;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // getcategoryData(widget.cat!.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InputField(
            label: "Search",
            controller: searchController,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                getcategoryData();
              },
              icon: const Icon(Icons.search))
        ],
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
                  child: CircularProgressIndicator(color: primary),
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
