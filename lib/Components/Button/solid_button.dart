import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SolidButton extends StatelessWidget {
  Color color;
  String label;
  Function()? onPressed;
  SolidButton({
    Key? key,
    this.color = Colors.orange,
    this.label = "",
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          color,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
