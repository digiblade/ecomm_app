import 'package:ecommerce/Components/Card/timeline_card.dart';
import 'package:ecommerce/Models/drawer_page.dart';
import 'package:ecommerce/Models/order_status_model.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DisplayStatusPage extends StatefulWidget {
  String? orderId = "";
  DisplayStatusPage({
    super.key,
    this.orderId = "",
  });

  @override
  State<DisplayStatusPage> createState() => _DisplayStatusPageState();
}

class _DisplayStatusPageState extends State<DisplayStatusPage> {
  List<OrderStatusModel> timeline = [];

  @override
  void initState() {
    super.initState();
    getOrderStatusData();
  }

  getOrderStatusData() async {
    Map<String, String> payload = {
      "orderId": widget.orderId ?? "",
    };
    List<OrderStatusModel> statusData = await getOrderStatus(payload);
    setState(() {
      timeline = statusData;
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
            TimelineCard(
              title: "Order Placed",
            ),
            ...timeline.map(
              (time) => TimelineCard(
                title: time.label ?? "",
                subtitle: time.remark ?? "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
