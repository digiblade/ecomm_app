import 'package:ecommerce/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import '../Card/card_component.dart';
import '../Card/category_card_component.dart';

// ignore: must_be_immutable
class CardSection extends StatefulWidget {
  List items;
  String sectionTitle;
  bool isProduct;
  CardSection(
      {Key? key,
      this.items = const [],
      this.sectionTitle = "",
      this.isProduct = false})
      : super(key: key);

  @override
  State<CardSection> createState() => _CardSectionState();
}

class _CardSectionState extends State<CardSection> {
  String displayType = 'horizontalList';
  IconData displayIcon = Icons.view_comfortable;
  Widget renderComponent() {
    switch (displayType.toLowerCase()) {
      case "horizontallist":
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widget.items.map((item) {
              if (widget.isProduct) {
                return CardComponent(
                  product: item,
                );
              } else {
                return CategoryCardComponent(
                  category: item.categoryName,
                  image: item.categoryImage,
                );
              }
            }).toList(),
          ),
        );
      case "gridview":
        return Wrap(
          children: widget.items.map((item) {
            if (widget.isProduct) {
              return CardComponent(
                product: item,
              );
            } else {
              return CategoryCardComponent(
                category: item.categoryName,
                image: item.categoryImage,
              );
            }
          }).toList(),
        );
      default:
        return const Text("No View Found");
    }
  }

  handleViewChange() {
    if (displayType.toLowerCase() == "horizontallist") {
      setState(() {
        displayType = "gridView";
        displayIcon = Icons.list;
      });
    } else {
      setState(() {
        displayType = "horizontalList";
        displayIcon = Icons.view_comfortable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.sectionTitle,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: handleViewChange,
                icon: Icon(
                  displayIcon,
                  size: 32,
                ),
              ),
            ],
          ),
          renderComponent()
        ],
      ),
    );
  }
}
