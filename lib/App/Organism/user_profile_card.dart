import 'package:ecommerce/Util/Colors.dart';
import 'package:ecommerce/Util/space.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatefulWidget {
  const UserProfileCard({Key? key}) : super(key: key);

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: gray,
                      ),
                    ),
                    const VerticalSpace(
                      space: 8,
                    ),
                    const Text(
                      "Akash Chourasia",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: gray,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        16,
                      ),
                    ),
                  ),
                  child: Image.asset("assets/images/avatar.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
