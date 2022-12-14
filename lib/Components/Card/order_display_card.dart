import 'package:ecommerce/Component2/Buttons/SolidButton.dart';
import 'package:ecommerce/Components/Card/cart_card.dart';
import 'package:ecommerce/Models/OrderModel.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class OrderDisplayCard extends StatefulWidget {
  OrderModel? order;
  OrderDisplayCard({super.key, this.order});

  @override
  State<OrderDisplayCard> createState() => _OrderDisplayCardState();
}

class _OrderDisplayCardState extends State<OrderDisplayCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Order Id: ${widget.order!.orderId!}",
                    style: const TextStyle(
                      color: secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                Expanded(
                  child: SolidButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/displaystatus",
                        arguments: widget.order,
                      );
                    },
                    label: "Track Order",
                  ),
                )
              ],
            ),
            Text(
              "Delivery Address: ${widget.order!.address}",
              style: TextStyle(
                color: gray,
                fontSize: 12,
              ),
            ),
            Text(
              "Current Status: ${widget.order!.state}",
              style: TextStyle(
                color: gray,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  "Total Payable",
                  style: TextStyle(
                    color: gray,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  " ${widget.order!.total}",
                  style: TextStyle(
                    color: gray,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ...widget.order!.cartProduct!
                    .map(
                      (prod) => CartCard(
                        cartRefresh: () {},
                        showDelete: false,
                        showQtyUpdate: false,
                        count: prod.count,
                        product: prod.product,
                      ),
                    )
                    .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
