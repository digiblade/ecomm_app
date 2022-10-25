import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  final Function()? onPressed;
  final String label;
  final Color color;
  const SolidButton(
      {Key? key,
      required this.onPressed,
      this.label = "",
      this.color = primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 12,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
