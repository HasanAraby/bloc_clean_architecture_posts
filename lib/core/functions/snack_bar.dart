import 'package:flutter/material.dart';

extension CustomSnack on BuildContext {
  snack(String str, bool error) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        str,
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey[200],
        ),
      ),
      backgroundColor: error ? Colors.red : Colors.green,
    ));
  }
}
