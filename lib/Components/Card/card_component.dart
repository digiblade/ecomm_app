import 'package:ecommerce/Models/cart_model.dart';
import 'package:ecommerce/Models/document_model.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:ecommerce/Util/space.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardComponent extends StatefulWidget {
  ProductModel product;
  CardComponent({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  double cardPadding = 0;
  addPadding(bool value) {
    if (value) {
      setState(() {
        cardPadding += 8;
      });
    } else {
      setState(() {
        cardPadding -= 8;
      });
    }
  }

  handleAddToCart() {
    addToCart(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pushNamed(context, "/productpage", arguments: widget.product);
      },
      child: Card(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Image.network(
                    getPathFromModel(widget.product.docList),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpace(
                        space: 4,
                      ),
                      Expanded(
                        child: Text(
                          limitString(widget.product.productName ?? "", 90),
                          style: const TextStyle(
                            color: secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const VerticalSpace(
                        space: 4,
                      ),
                      Expanded(
                        child: Text(
                          limitString(
                              widget.product.productDescription ?? "", 50),
                          style: TextStyle(
                            color: gray,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "${widget.product.offerPrice} /- ",
                          style: const TextStyle(
                            color: secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onHover: addPadding,
                        onTap: handleAddToCart,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          padding: EdgeInsets.only(right: cardPadding),
                          child: IconButton(
                            onPressed: () {
                              handleAddToCart();
                            },
                            icon: const Icon(
                              Icons.shopping_bag,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
