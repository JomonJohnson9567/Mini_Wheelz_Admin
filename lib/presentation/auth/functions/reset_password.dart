// Legacy helper left empty; functionality moved into AuthCubit.signInWithGoogle()
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

Future<void> resetPassword(BuildContext context) async {
  final email = TextEditingControllers
      .instance
      .passwordResetEmailcontroller
      .text
      .trim();

  if (email.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.materialRed,
        content: Text('Please enter an email'),
      ),
    );
    return;
  }

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    // Success message
    if (kDebugMode) {
      print('Password reset email: $email');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.buttonPrimary,
        content: Text('Password reset email sent successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
    TextEditingControllers.instance.passwordResetEmailcontroller.clear();
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else {
      message = 'Error: ${e.message ?? 'Something went wrong'}';
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));

    if (kDebugMode) {
      print('Error: $e');
    }
  }
}
