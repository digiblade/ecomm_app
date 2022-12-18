import 'dart:convert';
import 'package:ecommerce/App/Organism/product_slider.dart';
import 'package:ecommerce/Util/space.dart';

import '../Organism/banner_panel.dart';
import '../Organism/search_panel.dart';
import '../Organism/user_profile_card.dart';
import 'package:flutter/material.dart';

String jsonToString() {
  String finalString = '';
  try {
    Map mapStringData = <String, dynamic>{
      "title": "home",
      "components": [
        {
          "type": "user-profile",
          "width": "full",
          "hint": "search",
          "scope": ["user", "product", "location"],
          "content": {}
        },
        {
          "type": "search",
          "width": "full",
          "hint": "search",
          "scope": ["user", "product", "location"],
          "content": {}
        },
        {
          "type": "banner",
          "width": "full",
          "visibility": true,
          "imageSet": "1223-22213",
        },
        {
          "type": "product-list",
          "axis": "x-axis",
          "max-product": "10",
          "visibility": true,
        },
        {
          "type": "offer-list",
          "width": "full",
          "visibility": true,
          "imageSet": "1223-22213",
        },
        {
          "type": "category-list",
          "width": "full",
          "visibility": true,
          "imageSet": "1223-22213",
        },
        {
          "type": "orders",
          "width": "full",
          "visibility": true,
          "imageSet": "1223-22213",
        },
        {
          "type": "cart",
          "width": "full",
          "visibility": true,
          "imageSet": "1223-22213",
        }
      ]
    };
    finalString = json.encode(mapStringData);
  } catch (error) {
    // ignore: avoid_print
    print(error);
  }
  return finalString;
}

stringToJson(string) {
  try {
    return json.decode(string);
  } catch (error) {
    // ignore: avoid_print
    print("error: $error");
    return [];
  }
}

List<Widget> renderComponent(config) {
  try {
    Map<String, dynamic> configData = stringToJson(config);
    List components = configData['components'];
    List<Widget> componentList = [];
    for (dynamic component in components) {
      String type = component['type'];
      switch (type.toLowerCase()) {
        case "search":
          componentList.add(const SearchPanel());
          break;
        case "banner":
          componentList.add(const BannerPanel());
          break;
        case "product-list":
          componentList.add(const ProductSlider());
          break;
        case "category-list":
          componentList.add(const Text("Category List will come here"));
          break;
        case "offer-list":
          componentList.add(const Text("Offer list will come here"));
          break;
        case "user-profile":
          componentList.add(const UserProfileCard());
          break;
        default:
          break;
      }
      componentList.add(
        const VerticalSpace(
          space: 8,
        ),
      );
    }
    return componentList;
  } catch (error, stackData) {
    // ignore: avoid_print
    print("error: $error \n $stackData ");
  }
  return <Widget>[];
}
