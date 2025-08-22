import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class CreateAccountTextWidget extends StatelessWidget {
  final String message;
  final String? text;
  final VoidCallback onpress;
  const CreateAccountTextWidget({
    required this.message,
    this.text,
    required this.onpress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 100),
      child: Row(
        children: [
          Text(message, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onpress,
            child: Text(
              text!,
              style: TextStyle(
                color: AppColors.info,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
