import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Welcome to the Orders Page',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    
  }
}
