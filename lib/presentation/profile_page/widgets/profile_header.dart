import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_cubit.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'My Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),

        CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.surface,
          backgroundImage: const AssetImage('assets/images/user.png'),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              String? photoUrl;
              if (state is AuthAuthenticated) {
                photoUrl = state.user.photoURL;
              }
              if (photoUrl != null) {
                return ClipOval(
                  child: Image.network(
                    photoUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                );
              }
              return Icon(Icons.person, size: 60, color: Colors.grey[400]);
            },
          ),
        ),
        const SizedBox(height: 20),

        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            String displayName = 'User';
            if (state is AuthAuthenticated) {
              displayName = state.user.displayName ?? 'User';
            }
            return Text(
              displayName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          },
        ),
        const SizedBox(height: 8),

        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            String email = 'No email';
            if (state is AuthAuthenticated) {
              email = state.user.email ?? 'No email';
            }
            return Text(
              email,
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
            );
          },
        ),
        const SizedBox(height: 30),

        Container(height: 1, color: Colors.grey[800]),
        const SizedBox(height: 30),
      ],
    );
  }
}
