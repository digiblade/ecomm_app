import 'package:ecommerce/App/Pages/HomePage.dart';
import 'package:ecommerce/Auth/LoginPage.dart';
import 'package:ecommerce/Auth/RegistrationPage.dart';
import 'package:ecommerce/Components/Sections/product_section.dart';
import 'package:ecommerce/Models/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'Components/Banner/custom_banner_static.dart';
import 'Components/Card/category_card.dart';
import 'Components/Sections/card_section.dart';
import 'Page/google_map_page.dart';
import 'Page/product_page.dart';

import 'Components/Appbar/app_bar.dart';
import 'Components/Card/category_card_component.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WaitingPage(),
      routes: {
        "/app": (context) => const MyHomePage(title: "Home"),
        "/login": (context) => const LoginPage(),
        "/registration": (context) => const RegistrationPage(),
        "/productpage": (context) => ProductPage(),
        "/googlemap": (context) => GoogleMapPage(),
      },
    );
  }
}

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  bool isAuthorized = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    LocalStorage storage = LocalStorage("auth.json");

    var user = storage.getItem("userDetails");
    if (user != null) {
      isAuthorized = true;
    }
    isLoading = false;
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isLoggedIn = pref.getBool("isLoggedIn");
    if (isLoggedIn!) {
      setState(() {
        isAuthorized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (!isAuthorized) {
        return const LoginPage();
      } else {
        return const MyHomePage(title: "");
      }
    }
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CategoryModel> category = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    setCategory();
  }

  setCategory() async {
    setState(() {
      isLoading = true;
    });
    List<CategoryModel> tempCategory = await getAllCategory();
    setState(() {
      category = tempCategory;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    child: Center(
                      child: Icon(
                        Icons.supervised_user_circle,
                      ),
                    ),
                  ),
                  Text(
                    "User 1",
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                onDrawerOpen: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              const CustomBannerStatic(),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (!isLoading)
                CardSection(
                  sectionTitle: "Category",
                  items: category,
                ),
              // CardSection(
              //   sectionTitle: "Offers",
              //   items: const [
              //     'Buy Clothes starting at 100',
              //     'Get 5% off ',
              //     'Get 10% off',
              //   ],
              // ),
              // CardSection(
              //   sectionTitle: "Hot Favorite",
              //   isProduct: true,
              //   items: const [
              //     'Buy Clothes starting at 100',
              //     'Get 5% off ',
              //     'Get 10% off',
              //   ],
              // ),
              const ProductSection(),
              const CustomBannerStatic(),
              const CustomBannerStatic(),
            ],
          ),
        ),
      ),
    );
  }
}
