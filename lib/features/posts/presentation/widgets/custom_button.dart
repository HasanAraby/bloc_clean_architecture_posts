import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPress;
  final String txt;
  final Color? color;
  const CustomButton(
      {super.key, required this.onPress, required this.txt, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: MaterialButton(
        color: color ?? Colors.green,
        onPressed: onPress,
        textColor: Colors.white,
        child: Text(
          txt,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
