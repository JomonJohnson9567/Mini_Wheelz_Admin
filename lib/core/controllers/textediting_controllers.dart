import 'package:flutter/material.dart';

class TextEditingControllers {
  TextEditingControllers._();

  static final instance = TextEditingControllers._();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Login controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Add Category controllers
  final categorynameController = TextEditingController();
  final descriptionController = TextEditingController();

  // Add Product controllers
  final productNameController = TextEditingController();

  final productPriceController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productCategoryController = TextEditingController();
  final productQuantityController = TextEditingController();
  final productImageController = TextEditingController();
  final productquantityController = TextEditingController();

  //Forgot password
  final forgotpasswordController = TextEditingController();
  final passwordResetEmailcontroller = TextEditingController();

  // Clear all auth-related controllers
  void clearAuthControllers() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  // Clear signup controllers
  void clearSignupControllers() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // Clear login controllers
  void clearLoginControllers() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  // Clear category controllers
  void clearCategoryControllers() {
    categorynameController.clear();
    descriptionController.clear();
  }

  // Clear all controllers
  void clearAllControllers() {
    clearAuthControllers();
    categorynameController.clear();
    descriptionController.clear();
    productNameController.clear();
    productPriceController.clear();
    productDescriptionController.clear();
    productCategoryController.clear();
    productQuantityController.clear();
    productImageController.clear();
    productquantityController.clear();
  }

  // Dispose all controllers
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    categorynameController.dispose();
    descriptionController.dispose();
    productNameController.dispose();
    productPriceController.dispose();
    productDescriptionController.dispose();
    productCategoryController.dispose();
    productQuantityController.dispose();
    productImageController.dispose();
    productquantityController.dispose();
  }
}
