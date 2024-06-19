import 'package:flutter/material.dart';
import 'package:ree_rave/constant.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isHidden;
  final IconData icon;

  const TextInputField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.isHidden,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(labelText),
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(5)),
      ),
      obscureText: isHidden ? true : false,
    );
  }
}
