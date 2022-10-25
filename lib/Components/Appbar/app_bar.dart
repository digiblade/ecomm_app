import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  Function onDrawerOpen;
  CustomAppBar({Key? key, required this.onDrawerOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  onDrawerOpen();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 36,
                ),
                color: Colors.black54,
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: const [
                  Text(
                    "Current location",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "L/56 yadunandan nagar tifra bilaspur",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/googlemap");
                },
                icon: const Icon(
                  Icons.supervised_user_circle,
                  size: 36,
                ),
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
