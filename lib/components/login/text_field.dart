import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  const TextFieldLogin({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    required this.obscureText,
    required this.suffixIcon,
    required this.focusNode,
    required this.onFieldSubmitted,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final Function? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, right: 14, left: 14, bottom: 8),
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 15),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        ),
        cursorColor: Colors.black,
        keyboardType: textInputType,
        onFieldSubmitted: (_) {
          if (onFieldSubmitted != null) {
            onFieldSubmitted!(_); 
          }
        },
      ),
    );
  }
}
