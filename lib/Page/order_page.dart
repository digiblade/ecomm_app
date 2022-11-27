import 'package:ecommerce/Components/Card/order_display_card.dart';
import 'package:ecommerce/Models/DrawerPage.dart';
import 'package:ecommerce/Models/OrderModel.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class DisplayOrderPage extends StatefulWidget {
  const DisplayOrderPage({super.key});

  @override
  State<DisplayOrderPage> createState() => DisplayOrderPageState();
}

class DisplayOrderPageState extends State<DisplayOrderPage> {
  List<OrderModel> order = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderData();
  }

  getOrderData() async {
    List<OrderModel> tempOrder = await getOrder();
    setState(() {
      order = tempOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
      ),
      drawer: const DrawerPage(),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...order
                .map(
                  (OrderModel ord) => OrderDisplayCard(
                    order: ord,
                  ),
                )
                .toList(),
            // OrderDisplayCard(),
          ],
        ),
      ),
    );
  }
}
