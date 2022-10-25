import 'package:ecommerce/Components/Sections/card_section.dart';
import 'package:ecommerce/Models/SectionModel.dart';
import 'package:flutter/material.dart';
import "card_section.dart";

class ProductSection extends StatefulWidget {
  const ProductSection({Key? key}) : super(key: key);

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  bool isLoading = false;
  List<SectionModel> sectionList = [];
  @override
  void initState() {
    super.initState();
    getSections();
  }

  getSections() async {
    // try {
    setState(() {
      isLoading = true;
    });
    List<SectionModel> tempSection = await getAllSection();
    setState(() {
      sectionList = tempSection;
      isLoading = false;
    });
    // } catch (e) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   print("error: $e");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...sectionList
            .map(
              (SectionModel section) => CardSection(
                isProduct: true,
                items: section.productList,
                sectionTitle: section.sectionName!,
              ),
            )
            .toList(),
      ],
    );
  }
}
