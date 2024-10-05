import 'package:flutter/material.dart';

class PostFormField extends StatelessWidget {
  final String hintTxt;
  final String? Function(String?)? valid;
  final TextEditingController controller;
  final int lines;
  const PostFormField(
      {super.key,
      required this.hintTxt,
      required this.valid,
      required this.controller,
      required this.lines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.green,
          ),
        ),
        focusColor: Colors.green,
        hintText: hintTxt,
      ),
      minLines: lines,
      maxLines: lines,
      validator: valid,
      controller: controller,
    );
  }
}
