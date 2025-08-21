import 'package:flutter/material.dart';
 
 
import 'package:mini_wheelz/core/theme/app_colors.dart';

void showSwitchAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Switch Account',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to switch your Google account?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
               
            },
            child: const Text(
              'Switch',
              style: TextStyle(color: Color(0xFF4CAF50)),
            ),
          ),
        ],
      );
    },
  );
}
