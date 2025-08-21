import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/text_field/custom_text_field.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class CategoryNameFiled extends StatelessWidget {
  const CategoryNameFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: CustomTextField(
        hintStyle: const TextStyle(color: AppColors.textHint),
        fillcolor: const Color.fromARGB(255, 248, 246, 246),
        controller: TextEditingControllers.instance.categorynameController,
        hintText: 'Category Name',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your category Name';
          }
          return null;
        },
      ),
    );
  }
}
