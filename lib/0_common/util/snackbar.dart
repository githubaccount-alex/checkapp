import 'package:flutter/material.dart';

class SnackbarUtil {
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.greenAccent,
        content: Text(message),
      ),
    );
  }
}
