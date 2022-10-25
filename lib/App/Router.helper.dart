import 'package:ecommerce/App/Pages/HomePage.dart';
import 'package:flutter/material.dart';

const routeList = ["/home", "/about", "/product"];
Widget renderPage(String pageurl) {
  Widget? finalPage;
  switch (pageurl.toLowerCase()) {
    case "/home":
      finalPage = const HomePage();
      break;
    case "/404":
      finalPage = const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: Text(
            "404 page not found",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
      );
      break;
    default:
      finalPage = Text(pageurl);
  }
  return finalPage;
}

String pageRoute(index) {
  String route = "";
  if (index >= routeList.length || index < 0) {
    route = "/404";
  } else {
    route = routeList[index];
  }
  return route;
}

Widget renderingEngine(json) {
  return const Text("rendering Engine");
}
