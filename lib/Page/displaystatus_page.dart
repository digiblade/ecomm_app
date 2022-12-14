import 'package:ecommerce/Models/DrawerPage.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class DisplayStatusPage extends StatefulWidget {
  const DisplayStatusPage({super.key});

  @override
  State<DisplayStatusPage> createState() => _DisplayStatusPageState();
}

class _DisplayStatusPageState extends State<DisplayStatusPage> {
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
          children: const [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.message),
              ),
              title: Text("Shipped"),
              subtitle: Text("lorem ipsum"),
            )
          ],
        ),
      ),
    );
  }
}
