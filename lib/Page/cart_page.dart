import 'package:ecommerce/Components/Card/cart_card.dart';
import 'package:ecommerce/Models/CartModel.dart';
import 'package:ecommerce/Models/DrawerPage.dart';
import 'package:ecommerce/Page/address_page.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';
import '../Components/Appbar/app_bar.dart';
import '../Components/Button/solid_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CartModel> cartItems = [];
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

  getTotal(items) {
    double total = 0;
    for (CartModel item in cartItems) {
      total += double.parse(item.product!.offerPrice!) * item.count!;
    }
    return total;
  }

  getProductFromCart() async {
    List<CartModel> cart = await getCartByAPI();
    setState(() {
      cartItems = cart;
    });
  }

  @override
  void initState() {
    super.initState();
    getProductFromCart();
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: secondary,
      ),
      drawer: const DrawerPage(),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: cartItems.map((CartModel item) {
                    return CartCard(
                      product: item.product,
                      count: item.count,
                      cartRefresh: getProductFromCart,
                    );
                  }).toList(),
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
                        "₹ ${getTotal(cartItems)}/-",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SolidButton(
                        label: "Checkout",
                        onPressed: () {
                          Navigator.pushNamed(context, "/checkoutpage");
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
