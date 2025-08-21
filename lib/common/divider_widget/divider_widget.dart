
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final Color color;
  const DividerWidget({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: color, thickness: 1, indent: 20, endIndent: 20);
  }
}