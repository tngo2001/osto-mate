import 'package:flutter/material.dart';

class Snackbars {
  void showSnackbar(BuildContext context, String message, Color backgroundColor,
      TextStyle? textStyle) {
    final errorSnackbar = SnackBar(
        content: Text(message, style: textStyle),
        backgroundColor: backgroundColor);
    ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
  }
}
