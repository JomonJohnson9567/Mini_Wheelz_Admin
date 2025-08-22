import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/arrow_icon__ios/build_back_button.dart';
import 'package:mini_wheelz/common/header_text/header_text.dart';
import 'package:mini_wheelz/common/text_field/custom_text_field.dart';
import 'package:mini_wheelz/common/validation/validation_utils.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/auth/login/pages/login.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final _forgotkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _forgotkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildBackButton(context),
                  const SizedBox(height: 20),
                  HeaderText(title: 'Reset Your Password'),
                  const SizedBox(height: 25),
                  _buildIllustration(),
                  const SizedBox(height: 30),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 30),
                  _buildResetButton(context),
                  const SizedBox(height: 40),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Container(
      height: 220,
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        'https://img.freepik.com/premium-vector/forgot-password-concept-isolated-white_263070-194.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      validator: ValidationUtils.validateEmail,
      hintText: 'Enter Email',

      controller: TextEditingControllers.instance.passwordResetEmailcontroller,
      fillcolor: Colors.white,
      hintStyle: const TextStyle(color: AppColors.textHint),
    );
  }

  /// 🔑 Password Input
  Widget _buildPasswordField() {
    return CustomTextField(
      validator: ValidationUtils.validatePassword,
      hintText: 'Enter New Password',

      controller: TextEditingControllers.instance.forgotpasswordController,
      fillcolor: Colors.white,
      hintStyle: const TextStyle(color: AppColors.textHint),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 6,
        ),
        onPressed: () {
          if (kDebugMode) {
            print('Reset PassWord');
          }
          if (_forgotkey.currentState!.validate()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
        child: const Text("🔑 Reset Password"),
      ),
    );
  }

  /// 👣 Footer
  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(
              color: AppColors.info,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
