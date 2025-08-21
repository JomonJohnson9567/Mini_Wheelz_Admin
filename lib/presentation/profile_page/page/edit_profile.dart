// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mini_wheelz/core/theme/app_colors.dart';
// import 'package:mini_wheelz/core/utils/validation_utils.dart';
// import 'package:mini_wheelz/presentation/auth/bloc/auth_cubit.dart';
// import 'package:mini_wheelz/presentation/auth/bloc/auth_state.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});

//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   bool _hasChanges = false;

//   @override
//   void initState() {
//     super.initState();
//     // Add listeners to detect changes
//     _nameController.addListener(_onFieldChanged);
//     _emailController.addListener(_onFieldChanged);
//     _passwordController.addListener(_onFieldChanged);
//     _confirmPasswordController.addListener(_onFieldChanged);
//   }

//   void _onFieldChanged() {
//     setState(() {
//       _hasChanges =
//           _nameController.text.isNotEmpty ||
//           _emailController.text.isNotEmpty ||
//           _passwordController.text.isNotEmpty ||
//           _confirmPasswordController.text.isNotEmpty;
//     });
//   }

//   @override
//   void dispose() {
//     _nameController.removeListener(_onFieldChanged);
//     _emailController.removeListener(_onFieldChanged);
//     _passwordController.removeListener(_onFieldChanged);
//     _confirmPasswordController.removeListener(_onFieldChanged);
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _clearPasswordFields() {
//     _passwordController.clear();
//     _confirmPasswordController.clear();
//     setState(() {
//       _hasChanges =
//           _nameController.text.isNotEmpty || _emailController.text.isNotEmpty;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.signupbkgColor,
//       appBar: AppBar(
//         title: const Text(
//           "Edit Profile",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: AppColors.surface,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           if (_hasChanges)
//             TextButton(
//               onPressed: () {
//                 _clearPasswordFields();
//                 setState(() {
//                   _hasChanges = false;
//                 });
//               },
//               child: const Text(
//                 "Reset",
//                 style: TextStyle(color: Colors.white70),
//               ),
//             ),
//         ],
//       ),
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is ProfileUpdateError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//                 behavior: SnackBarBehavior.floating,
//                 duration: const Duration(seconds: 4),
//                 action: SnackBarAction(
//                   label: 'Dismiss',
//                   textColor: Colors.white,
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                   },
//                 ),
//               ),
//             );
//           } else if (state is ProfileUpdateSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.green,
//                 behavior: SnackBarBehavior.floating,
//                 duration: const Duration(seconds: 3),
//               ),
//             );
//             _clearPasswordFields();
//             setState(() {
//               _hasChanges = false;
//             });
//           } else if (state is AuthError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//                 behavior: SnackBarBehavior.floating,
//                 duration: const Duration(seconds: 4),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is AuthAuthenticated) {
//             final userData = state.userData ?? {};
//             // Initialize controllers with current values if they're empty
//             if (_nameController.text.isEmpty) {
//               _nameController.text = userData['name'] ?? '';
//             }
//             if (_emailController.text.isEmpty) {
//               _emailController.text = state.user.email ?? '';
//             }

//             return Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [AppColors.surface, AppColors.signupbkgColor],
//                 ),
//               ),
//               child: SafeArea(
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Profile Picture Section
//                         _buildProfilePicture(),
//                         const SizedBox(height: 32),

//                         // Form Fields
//                         _buildNameField(),
//                         const SizedBox(height: 20),

//                         _buildEmailField(),
//                         const SizedBox(height: 20),

//                         _buildPasswordField(),
//                         const SizedBox(height: 20),

//                         if (_passwordController.text.isNotEmpty)
//                           _buildConfirmPasswordField(),
//                         if (_passwordController.text.isNotEmpty)
//                           const SizedBox(height: 20),

//                         const SizedBox(height: 32),

//                         // Action Buttons
//                         _buildActionButtons(context, state),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }

//           if (state is ProfileUpdateLoading) {
//             return _buildLoadingState();
//           }

//           if (state is AuthLoading) {
//             return _buildLoadingState();
//           }

//           return _buildErrorState();
//         },
//       ),
//     );
//   }

//   Widget _buildProfilePicture() {
//     return Center(
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: AppColors.buttonPrimary, width: 3),
//             ),
//             child: CircleAvatar(
//               radius: 60,
//               backgroundColor: AppColors.surface,
//               child: Icon(Icons.person, size: 60, color: AppColors.whitecolor),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: AppColors.buttonPrimary,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: const Icon(
//                 Icons.camera_alt,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNameField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: _nameController,
//         decoration: InputDecoration(
//           labelText: "Full Name",
//           hintText: "Enter your full name",
//           prefixIcon: const Icon(
//             Icons.person_outline,
//             color: AppColors.whitecolor,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: AppColors.surface,
//           labelStyle: const TextStyle(color: AppColors.whitecolor),
//           hintStyle: TextStyle(color: AppColors.whitecolor.withOpacity(0.7)),
//         ),
//         style: const TextStyle(color: AppColors.whitecolor),
//         validator: (value) => ValidationUtils.validateRequired(value, 'name'),
//       ),
//     );
//   }

//   Widget _buildEmailField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: _emailController,
//         decoration: InputDecoration(
//           labelText: "Email",
//           hintText: "Enter your email address",
//           prefixIcon: const Icon(
//             Icons.email_outlined,
//             color: AppColors.whitecolor,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: AppColors.surface,
//           labelStyle: const TextStyle(color: AppColors.whitecolor),
//           hintStyle: TextStyle(color: AppColors.whitecolor.withOpacity(0.7)),
//         ),
//         style: const TextStyle(color: AppColors.whitecolor),
//         keyboardType: TextInputType.emailAddress,
//         validator: ValidationUtils.validateEmail,
//       ),
//     );
//   }

//   Widget _buildPasswordField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: _passwordController,
//         decoration: InputDecoration(
//           labelText: "New Password (optional)",
//           hintText: "Leave blank to keep current password",
//           prefixIcon: const Icon(
//             Icons.lock_outline,
//             color: AppColors.whitecolor,
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(
//               _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
//               color: AppColors.whitecolor,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isPasswordVisible = !_isPasswordVisible;
//               });
//             },
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: AppColors.surface,
//           labelStyle: const TextStyle(color: AppColors.whitecolor),
//           hintStyle: TextStyle(color: AppColors.whitecolor.withOpacity(0.7)),
//           helperText:
//               "Must be at least 8 characters with uppercase, lowercase, and number",
//           helperStyle: TextStyle(color: AppColors.whitecolor.withOpacity(0.7)),
//         ),
//         style: const TextStyle(color: AppColors.whitecolor),
//         obscureText: !_isPasswordVisible,
//         validator: (value) {
//           if (value != null && value.isNotEmpty) {
//             return ValidationUtils.validateStrongPassword(value);
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildConfirmPasswordField() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: _confirmPasswordController,
//         decoration: InputDecoration(
//           labelText: "Confirm New Password",
//           hintText: "Confirm your new password",
//           prefixIcon: const Icon(
//             Icons.lock_outline,
//             color: AppColors.whitecolor,
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(
//               _isConfirmPasswordVisible
//                   ? Icons.visibility_off
//                   : Icons.visibility,
//               color: AppColors.whitecolor,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
//               });
//             },
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: AppColors.surface,
//           labelStyle: const TextStyle(color: AppColors.whitecolor),
//           hintStyle: TextStyle(color: AppColors.whitecolor.withOpacity(0.7)),
//         ),
//         style: const TextStyle(color: AppColors.whitecolor),
//         obscureText: !_isConfirmPasswordVisible,
//         validator: (value) {
//           if (_passwordController.text.isNotEmpty) {
//             return ValidationUtils.validateConfirmPassword(
//               value,
//               _passwordController.text,
//             );
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildActionButtons(BuildContext context, AuthState state) {
//     return Column(
//       children: [
//         // Save Button
//         SizedBox(
//           width: double.infinity,
//           height: 56,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: _hasChanges
//                   ? AppColors.buttonPrimary
//                   : Colors.grey,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               elevation: _hasChanges ? 8 : 0,
//               shadowColor: _hasChanges
//                   ? AppColors.buttonPrimary.withOpacity(0.3)
//                   : Colors.transparent,
//             ),
//             onPressed: (_hasChanges && state is! ProfileUpdateLoading)
//                 ? () {
//                     if (_formKey.currentState!.validate()) {
//                       context.read<AuthCubit>().updateProfile(
//                         name: _nameController.text.trim(),
//                         email: _emailController.text.trim(),
//                         password: _passwordController.text.isNotEmpty
//                             ? _passwordController.text.trim()
//                             : null,
//                       );
//                     }
//                   }
//                 : null,
//             child: state is ProfileUpdateLoading
//                 ? const SizedBox(
//                     height: 24,
//                     width: 24,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//                 : const Text(
//                     "Save Changes",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//           ),
//         ),
//         const SizedBox(height: 16),

//         // Cancel Button
//         SizedBox(
//           width: double.infinity,
//           height: 56,
//           child: OutlinedButton(
//             style: OutlinedButton.styleFrom(
//               side: BorderSide(color: AppColors.buttonPrimary, width: 2),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text(
//               "Cancel",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.buttonPrimary,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoadingState() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [AppColors.surface, AppColors.signupbkgColor],
//         ),
//       ),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 AppColors.buttonPrimary,
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               "Updating profile...",
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [AppColors.surface, AppColors.signupbkgColor],
//         ),
//       ),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, size: 80, color: Colors.white70),
//             SizedBox(height: 24),
//             Text(
//               "No user data available",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             SizedBox(height: 12),
//             Text(
//               "Please log in to edit your profile",
//               style: TextStyle(fontSize: 16, color: Colors.white70),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
