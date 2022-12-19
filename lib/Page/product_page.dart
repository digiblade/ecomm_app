import 'package:ecommerce/Models/cart_model.dart';
import 'package:ecommerce/Models/document_model.dart';
import 'package:ecommerce/Models/drawer_page.dart';
import 'package:ecommerce/Models/product_model.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';
// import '../Components/Appbar/app_bar.dart';
import '../Components/Button/solid_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int quantity = 1;
  double price = 0;

  increment() {
    if (quantity < 20) {
      setState(() {
        quantity += 1;
      });
    }
  }

  addProductPrice(productPrice) {
    setState(() {
      price = double.parse(productPrice);
    });
  }

  decrement() {
    if (quantity > 1) {
      setState(() {
        quantity -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments! as ProductModel;
    addProductPrice(product.offerPrice);
    return Scaffold(
      appBar: AppBar(backgroundColor: secondary),
      key: _scaffoldKey,
      drawer: const DrawerPage(),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...getPathFromModelScrollView(product.docList)
                              .map(
                                (image) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      child: Image.network(
                                        getPathFromModel(product.docList),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      onPressed: decrement,
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.redAccent,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      onPressed: increment,
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.greenAccent,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.productDescription!,
                        style: TextStyle(
                          fontSize: 12,
                          color: black.withOpacity(0.7),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "₹ ${price * quantity} /-",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SolidButton(
                        label: "Add to cart",
                        onPressed: () async {
                          await addToCartByAPI(product, count: quantity);
                        },
                        color: secondary,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
