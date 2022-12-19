import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset('assets/images/Products/Orange.png'),
            ),
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Orange Fruit",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Fruit",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
