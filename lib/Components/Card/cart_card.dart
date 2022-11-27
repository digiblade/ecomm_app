import 'package:ecommerce/Component2/Buttons/SolidButton.dart';
import 'package:ecommerce/Models/CartModel.dart';
import 'package:ecommerce/Models/DocumentModel.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:ecommerce/Util/Space.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  int? count;
  ProductModel? product;
  Function() cartRefresh;
  bool showDelete;
  bool showQtyUpdate;
  CartCard({
    super.key,
    this.count = 0,
    this.product,
    required this.cartRefresh,
    this.showDelete = false,
    this.showQtyUpdate = true,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      getPathFromModel(widget.product!.docList),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product!.productName!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const VerticalSpace(
                          space: 4,
                        ),
                        Text(
                          limitString(widget.product!.productDescription!, 100),
                          style: TextStyle(
                            fontSize: 10,
                            color: black.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const VerticalSpace(
                          space: 4,
                        ),
                        Text(
                          "₹ ${widget.product!.offerPrice} /-",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black.withOpacity(
                              0.6,
                            ),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpace(
              space: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.showQtyUpdate)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primary,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            8,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                await removeToCartByAPI(widget.product!);
                                widget.cartRefresh();
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 14,
                              ),
                            ),
                          ),
                          Text(
                            "${widget.count}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: secondary,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                await addToCartByAPI(widget.product!);
                                widget.cartRefresh();
                              },
                              child: const Icon(
                                Icons.add,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (widget.showQtyUpdate == false)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primary,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            8,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${widget.count} x ${widget.product!.offerPrice}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (widget.showDelete)
                  SolidButton(
                    onPressed: () {},
                    label: "Delete",
                    color: secondary,
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
