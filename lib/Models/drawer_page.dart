import 'package:ecommerce/Auth/Auth.helper/auth.helper.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String username = "";
  String email = "-";
  @override
  void initState() {
    super.initState();
    LocalStorage storage = LocalStorage("auth.json");
    dynamic data = storage.getItem("userDetails");

    setState(() {
      username = data['name'];
      email = data['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: secondary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello $username",
                    style: TextStyle(
                      color: gray,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Email $email",
                    style: TextStyle(
                      color: gray,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Cart'),
              onTap: () {
                Navigator.pushNamed(context, "/cartpage");
              },
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, "/app");
              },
            ),
            ListTile(
              title: const Text('Your Order'),
              onTap: () {
                Navigator.pushNamed(context, "/viewOrderPage");
              },
            ),
            // ListTile(
            //   title: const Text('Manage Profile'),
            //   onTap: () {},
            // ),
            ListTile(
              title: const Text('Manage Addresses'),
              onTap: () {
                Navigator.pushNamed(context, "/addresspage");
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                await logoutClient();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
