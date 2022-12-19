import 'package:ecommerce/App/Molecule/product_card.dart';
import 'package:flutter/material.dart';

class ProductSlider extends StatefulWidget {
  const ProductSlider({Key? key}) : super(key: key);

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          ProductCard(),
        ],
      ),
    );
  }
}
