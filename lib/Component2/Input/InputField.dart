import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final bool isPassword;
  const InputField({
    Key? key,
    this.controller,
    this.label = "",
    this.hint = "",
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isShow = false;
  handleShow() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          obscureText: widget.isPassword ? !isShow : false,
          controller: widget.controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            labelStyle: const TextStyle(color: primary),
            labelText: widget.label,
            hintText: widget.hint,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: handleShow,
                    icon: Icon(
                      isShow ? Icons.visibility : Icons.visibility_off,
                      color: primary,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
