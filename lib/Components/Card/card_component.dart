import 'package:ecommerce/Models/CartModel.dart';
import 'package:ecommerce/Models/DocumentModel.dart';
import 'package:ecommerce/Models/ProductModel.dart';
import 'package:flutter/material.dart';

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
    bool res = addToCart(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pushNamed(context, "/productpage", arguments: widget.product);
      },
      child: Card(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 150,
                child: Image.network(
                  getPathFromModel(widget.product.docList),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.product.productName!,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.product.productDescription!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.product.offerPrice} /- ",
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                          onPressed: () {},
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
