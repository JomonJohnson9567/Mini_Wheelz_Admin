import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/common/buttons/button_signpage.dart';
import 'package:mini_wheelz/common/buttons/google_auth_button.dart';
import 'package:mini_wheelz/common/signup_text/sigin_header_text.dart';
import 'package:mini_wheelz/common/text_field/custom_text_field.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/common/validation/validation_utils.dart';
import 'package:mini_wheelz/presentation/auth/login/pages/login.dart';
import 'package:mini_wheelz/presentation/auth/signin/widget/illustration_widget.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_cubit.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_state.dart';
import 'package:mini_wheelz/common/bottom_navbar/bottom_nav.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  String email = "";
  String password = "";
  String username = "";
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.signupbkgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: signUpFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const IllustrationWidget(),
                const SizedBox(height: 40),
                SIgnUpText(text: 'Sign Up'),
                const SizedBox(height: 40),

                // Username
                CustomTextField(
                  hintStyle: const TextStyle(color: AppColors.whitecolor),
                  fillcolor: AppColors.surface,
                  controller:
                      TextEditingControllers.instance.usernameController,
                  hintText: 'Username',
                  validator: ValidationUtils.validateUsername,
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  hintStyle: const TextStyle(color: AppColors.whitecolor),
                  fillcolor: AppColors.surface,
                  controller: TextEditingControllers.instance.emailController,
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
                      TextEditingControllers.instance.passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: ValidationUtils.validateStrongPassword,
                ),
                const SizedBox(height: 16),

                // Confirm Password
                CustomTextField(
                  hintStyle: const TextStyle(color: AppColors.whitecolor),
                  fillcolor: AppColors.surface,
                  controller:
                      TextEditingControllers.instance.confirmPasswordController,
                  hintText: 'Confirm Password',
                  isPassword: true,
                  validator: (value) => ValidationUtils.validateConfirmPassword(
                    value,
                    TextEditingControllers.instance.passwordController.text,
                  ),
                ),
                const SizedBox(height: 24),

                // Sign Up Button
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                    if (state is AuthAuthenticated) {
                      // Clear auth fields after successful sign up
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
                      text: isLoading ? 'Creating account...' : 'Sign Up',
                      onPressed: () {
                        if (isLoading) return;
                        if (signUpFormKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().signUpWithEmail(
                            email: TextEditingControllers
                                .instance
                                .emailController
                                .text
                                .trim(),
                            password: TextEditingControllers
                                .instance
                                .passwordController
                                .text
                                .trim(),
                            username: TextEditingControllers
                                .instance
                                .usernameController
                                .text
                                .trim(),
                          );
                        }
                      },
                      backgroundColor: AppColors.buttonPrimary,
                    );
                  },
                ),
                const SizedBox(height: 24),

                const Text(
                  'Or',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
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
                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 100),
                  child: Row(
                    children: [
                      const Text('Already have an account?'),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: AppColors.info,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
