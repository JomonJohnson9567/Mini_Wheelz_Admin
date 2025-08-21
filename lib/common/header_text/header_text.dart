import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class HeaderText extends StatelessWidget {
  final String title;

  const HeaderText({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
