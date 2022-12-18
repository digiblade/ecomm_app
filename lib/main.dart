// import 'package:ecommerce/App/Pages/home_page.dart';
import 'package:ecommerce/Auth/login_page.dart';
import 'package:ecommerce/Auth/registration_page.dart';
import 'package:ecommerce/Components/Sections/product_section.dart';
import 'package:ecommerce/Models/category_model.dart';
import 'package:ecommerce/Models/drawer_page.dart';
import 'package:ecommerce/Page/404page.dart';
import 'package:ecommerce/Page/address_page.dart';
import 'package:ecommerce/Page/cart_page.dart';
import 'package:ecommerce/Page/category_page.dart';
import 'package:ecommerce/Page/checkout_page.dart';
import 'package:ecommerce/Page/displaystatus_page.dart';
import 'package:ecommerce/Page/order_page.dart';
import 'package:ecommerce/Page/order_response_page.dart';
import 'package:ecommerce/Page/search_page.dart';
import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
// import 'Components/Banner/custom_banner_static.dart';
// import 'Components/Card/category_card.dart';
import 'Components/Sections/card_section.dart';
// import 'Page/google_map_page.dart';
import 'Page/product_page.dart';

// import 'Components/Appbar/app_bar.dart';
// import 'Components/Card/category_card_component.dart';
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
      home: const WaitingPage(),
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          "/app": (context) => const MyHomePage(title: "Home"),
          "/login": (context) => const LoginPage(),
          "/registration": (context) => const RegistrationPage(),

          "/cartpage": (context) => const CartPage(),
          "/addresspage": (context) => const AddressPage(),
          "/checkoutpage": (context) => const CheckoutPage(),
          "/responsesuccesspage": (context) => OrderResponsePage(
                type: "success",
              ),
          "/responsefailpage": (context) => OrderResponsePage(type: "failure"),
          "/responseerrorpage": (context) => OrderResponsePage(),
          // "/googlemap": (context) => GoogleMapPage(),
          "/categoryPage": (context) =>
              CategoryProductPage(cat: settings.arguments as CategoryModel),
          "/viewOrderPage": ((context) => const DisplayOrderPage()),
          "/displaystatus": ((context) => DisplayStatusPage(
                orderId: settings.arguments as String,
              )),
          "/searchPage": ((context) => SearchPage())
        };
        WidgetBuilder? builder = routes[settings.name!];

        return MaterialPageRoute(
            builder: (ctx) =>
                builder != null ? builder(ctx) : const NotFoundPage());
      },
      routes: {
        "/productpage": (context) => const ProductPage(),
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
    bool? isLoggedIn = pref.getBool("isLoggedIn") ?? false;
    if (isLoggedIn) {
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
      appBar: AppBar(
        backgroundColor: secondary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/searchPage");
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      drawer: const DrawerPage(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const CustomBannerStatic(),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (!isLoading)
                CardSection(
                  sectionTitle: "Category",
                  items: category,
                ),
              const ProductSection(),
            ],
          ),
        ),
      ),
    );
  }
}
