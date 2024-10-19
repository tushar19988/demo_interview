import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPassword;
  final String? labelText;
  final int maxLines;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? errorText;

  const CommonTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.isPassword = false,
    this.labelText,
    this.maxLines = 1,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(),
        errorText: errorText,
      ),
      maxLines: maxLines,
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}

class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CommonButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
