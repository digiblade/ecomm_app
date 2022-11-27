import 'package:ecommerce/Component2/Buttons/SolidButton.dart';
import 'package:ecommerce/Models/DrawerPage.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:ecommerce/Util/Space.dart';
import 'package:flutter/material.dart';

class OrderResponsePage extends StatefulWidget {
  String type;
  OrderResponsePage({
    super.key,
    this.type = "error",
  });

  @override
  State<OrderResponsePage> createState() => _OrderResponsePageState();
}

class _OrderResponsePageState extends State<OrderResponsePage> {
  renderInfo(String resType) {
    switch (resType.toLowerCase()) {
      case "success":
        return const Success();
      case "failure":
        return const FailurePage();
      default:
        return const ErrorPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondary,
      ),
      drawer: const DrawerPage(),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: renderInfo(widget.type),
    );
  }
}

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/GIF/checkmark.png",
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const Text(
            "Order Placed",
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const VerticalSpace(
            space: 16,
          ),
          SolidButton(
            onPressed: () {},
            label: "Go to home page",
            color: secondary,
          )
        ],
      ),
    );
  }
}

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: MediaQuery.of(context).size.width * 0.5,
            color: Colors.yellowAccent,
          ),
          const Text(
            "Something went wrong",
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class FailurePage extends StatefulWidget {
  const FailurePage({super.key});

  @override
  State<FailurePage> createState() => _FailurePageState();
}

class _FailurePageState extends State<FailurePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: MediaQuery.of(context).size.width * 0.5,
            color: danger,
          ),
          const Text(
            "Something went wrong",
            style: TextStyle(
              color: danger,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
