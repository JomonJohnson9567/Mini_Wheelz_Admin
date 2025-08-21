import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_cubit.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_state.dart';

import 'package:mini_wheelz/common/bottom_navbar/bottom_nav.dart';
import 'package:mini_wheelz/presentation/auth/login/pages/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          context.read<AuthCubit>().checkAuthStatus();
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AuthAuthenticated) {
          return const BottomNavBar();
        }
        return LoginPage();
      },
    );
  }
}
