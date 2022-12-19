import 'package:ecommerce/Models/cart_model.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TotalCard extends StatefulWidget {
  List<CartModel> productList;
  TotalCard({
    super.key,
    this.productList = const <CartModel>[],
  });

  @override
  State<TotalCard> createState() => _TotalCardState();
}

class _TotalCardState extends State<TotalCard> {
  getTotal(list) {
    double total = 0;
    for (CartModel product in list) {
      total += product.count! * double.parse(product.product!.offerPrice!);
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Total payable:",
                    style: TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${getTotal(widget.productList)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
