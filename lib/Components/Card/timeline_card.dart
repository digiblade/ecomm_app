import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimelineCard extends StatelessWidget {
  String title;
  String subtitle;
  Icon timelineIcon;
  TimelineCard({
    super.key,
    this.title = "",
    this.subtitle = "",
    this.timelineIcon = const Icon(Icons.verified_user),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 20,
                width: 2,
                color: secondary,
              ),
              CircleAvatar(
                radius: 14,
                backgroundColor: secondary,
                foregroundColor: Colors.white,
                child: timelineIcon,
              ),
              Container(
                height: 20,
                width: 2,
                color: secondary,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ),
      ],
    );
  }
}
