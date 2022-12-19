import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerPanel extends StatefulWidget {
  const BannerPanel({Key? key}) : super(key: key);

  @override
  State<BannerPanel> createState() => _BannerPanelState();
}

class _BannerPanelState extends State<BannerPanel> {
  List bannerList = ["banner2.jpg", "banner3.jpg"];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options:
          CarouselOptions(height: MediaQuery.of(context).size.height * 0.3),
      items: bannerList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                "assets/images/$i",
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
