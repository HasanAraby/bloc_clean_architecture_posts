import 'package:flutter/material.dart';

extension CustomSnack on BuildContext {
  snack(String str) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(str)));
  }
}
