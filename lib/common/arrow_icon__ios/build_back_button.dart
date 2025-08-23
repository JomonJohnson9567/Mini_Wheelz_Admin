import 'package:flutter/material.dart';

Widget buildBackButton(BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
      onPressed: () => Navigator.pop(context),
    ),
  );
}
