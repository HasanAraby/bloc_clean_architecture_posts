import 'package:flutter/material.dart';

extension CustomNavigation on BuildContext {
  push(Widget screen) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  replace(Widget screen) {
    Navigator.of(this).pushReplacement(MaterialPageRoute(builder: (context) {
      return screen;
    }));
  }

  pop() {
    Navigator.of(this).pop();
  }

  mayPop() {
    Navigator.of(this).maybePop();
  }

  bool canPop() {
    return Navigator.of(this).canPop();
  }

  clearPush(Widget screen) {
    Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }
}
