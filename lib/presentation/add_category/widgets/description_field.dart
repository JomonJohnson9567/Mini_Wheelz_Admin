import 'package:flutter/material.dart';

import 'package:mini_wheelz/core/theme/app_colors.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  const DescriptionField({
    required this.controller,
    required this.hintText,

    required this.validator,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        controller: controller,
        maxLines: 5,
        validator: validator,
        onChanged: onChanged,
        scrollPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 100,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whitecolor,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          hintText: 'Description',
          hintStyle: const TextStyle(color: AppColors.textHint),
        ),
      ),
    );
  }
}
