import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_cubit.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_state.dart';
import 'package:mini_wheelz/presentation/auth/login/pages/login.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';

Widget buildSignOutButton(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: OutlinedButton.icon(
      onPressed: () {
        _showSignOutDialog(context);
      },
      icon: const Icon(Icons.logout, color: Colors.red),
      label: const Text(
        'Sign Out',
        style: TextStyle(fontSize: 16, color: Colors.red),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surface,
        side: const BorderSide(color: Colors.red, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
    ),
  );
}

void _showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Sign Out', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;
              return TextButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        Navigator.of(context).pop();
                        await context.read<AuthCubit>().signOut();
                        // Clear fields after sign out
                        TextEditingControllers.instance.clearAuthControllers();
                        if (context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => LoginPage()),
                            (route) => false,
                          );
                        }
                      },
                child: Text(
                  isLoading ? 'Signing out...' : 'Sign Out',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
