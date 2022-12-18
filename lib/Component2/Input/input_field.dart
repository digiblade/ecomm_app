import 'package:ecommerce/Util/Colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final bool isPassword;
  final TextInputType type;
  final Function(dynamic)? onChange;
  const InputField({
    Key? key,
    this.controller,
    this.label = "",
    this.hint = "",
    this.isPassword = false,
    this.type = TextInputType.text,
    this.onChange,
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
          onChanged: (val) {
            dynamic func = widget.onChange ?? (val) {};
            func(val);
          },
          obscureText: widget.isPassword ? !isShow : false,
          controller: widget.controller,
          keyboardType: widget.type,
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
