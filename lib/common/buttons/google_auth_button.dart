// Reusable Google Sign In Button Widget
import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://developers.google.com/identity/images/g-logo.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        label: const Text(
          'Sign in with google',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.customWhite,
          side: const BorderSide(color: Colors.grey, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}

// Reusable Illustration Widget
