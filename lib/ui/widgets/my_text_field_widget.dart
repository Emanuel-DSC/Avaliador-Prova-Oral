import 'package:flutter/material.dart';
import '../../utils/themes.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required TextEditingController controller,
    required this.inputType,
    required this.hintText,
    this.onChanged,
    this.fillColor,
    this.icon,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String hintText;
  final TextInputType inputType;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorWidth: 2.5,
      cursorRadius: const Radius.circular(15),
      controller: _controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(
          icon ?? Icons.person,
          color: AppTheme.textColorSecondary,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.textColorSecondary),
        filled: true,
        fillColor: fillColor ?? AppTheme.textFieldBackgroundColor,
      ),
    );
  }
}
