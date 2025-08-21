import 'package:flutter/material.dart';

class SIgnUpText extends StatelessWidget {
  final String text;
  const SIgnUpText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        color: Colors.black87,
      ),
    );
  }
}
