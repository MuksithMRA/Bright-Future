import 'package:flutter/material.dart';

class TextFieldData {
  String label;
  IconData prefixIcon;
  bool isPassword;
  TextFieldData({
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
  });
}
