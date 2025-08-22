import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class ProductViewpage extends StatelessWidget {
  const ProductViewpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Text(
            'Product View Page Coming Soon',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
