import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/common/bottom_navbar/bottom_nav.dart';
import 'package:mini_wheelz/common/buttons/button_signpage.dart';
import 'package:mini_wheelz/common/buttons/google_auth_button.dart';
import 'package:mini_wheelz/common/signup_text/sigin_header_text.dart';
import 'package:mini_wheelz/common/text_field/custom_text_field.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/common/validation/validation_utils.dart';
import 'package:mini_wheelz/presentation/auth/forgot_password/forgot_password_page.dart';
import 'package:mini_wheelz/presentation/auth/signin/pages/signin.dart';
import 'package:mini_wheelz/presentation/auth/signin/widget/illustration_widget.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_cubit.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.signupbkgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const IllustrationWidget(),
                const SizedBox(height: 40),
                SIgnUpText(text: 'Log In'),
                const SizedBox(height: 40),

                // Email
                CustomTextField(
                  hintStyle: const TextStyle(color: AppColors.whitecolor),
                  fillcolor: AppColors.surface,
                  controller:
                      TextEditingControllers.instance.loginEmailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationUtils.validateEmail,
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  hintStyle: const TextStyle(color: AppColors.whitecolor),
                  fillcolor: AppColors.surface,
                  controller:
                      TextEditingControllers.instance.loginPasswordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: ValidationUtils.validatePassword,
                ),
                const SizedBox(height: 16),

                // Login Button
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                    if (state is AuthAuthenticated) {
                      // Clear auth fields after successful login
                      TextEditingControllers.instance.clearAuthControllers();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const BottomNavBar()),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    final bool isLoading = state is AuthLoading;
                    return CustomButton(
                      text: isLoading ? 'Logging in...' : 'Log In',
                      onPressed: () {
                        if (isLoading) return;
                        if (_loginFormKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().signInWithEmail(
                            email: TextEditingControllers
                                .instance
                                .loginEmailController
                                .text
                                .trim(),
                            password: TextEditingControllers
                                .instance
                                .loginPasswordController
                                .text
                                .trim(),
                          );
                        }
                      },
                      backgroundColor: AppColors.buttonPrimary,
                    );
                  },
                ),
                const SizedBox(height: 16),

                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (kDebugMode) {
                          print("forgot password");
                        }
                        Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(color: AppColors.info),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 24),

                const Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final bool isLoading = state is AuthLoading;
                    return GoogleSignInButton(
                      onPressed: () {
                        if (isLoading) return;
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 100),
                  child: Row(
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors.info,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
