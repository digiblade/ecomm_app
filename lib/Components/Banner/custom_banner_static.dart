import 'package:flutter/material.dart';

class CustomBannerStatic extends StatelessWidget {
  const CustomBannerStatic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/banner/banner.jpg',
        ),
      ),
    );
  }
}
