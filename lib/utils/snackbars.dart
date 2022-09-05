import 'package:flutter/material.dart';

class Snackbars {
  static void showSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    final snackbar =
        SnackBar(content: Text(message), backgroundColor: backgroundColor);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    final errorSnackbar = SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).colorScheme.error,
    );
    ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
  }

  static void showSuccessSnackbar(BuildContext context, String message) {
    final errorSnackbar = SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary);
    ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
  }
}
