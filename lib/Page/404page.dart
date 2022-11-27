import 'package:ecommerce/Models/DrawerPage.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => NotFoundPageState();
}

class NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: secondary,
        ),
        drawer: const DrawerPage(),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: const Center(
          child: Text(
            "404 Page Not Found",
            style: TextStyle(
              color: secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
