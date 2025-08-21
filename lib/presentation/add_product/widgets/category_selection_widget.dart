
import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/text_field/select_category_field.dart/select_category_field.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class CategorySelectionWidget extends StatelessWidget {
  const CategorySelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SelectCategoryField(
        controller: TextEditingControllers
            .instance
            .productCategoryController,
        fillcolor: AppColors.textPrimary,
        hintText: 'Select Category',
        hintStyle: TextStyle(color: AppColors.textHint),
        dropdownItems: [
          'Electronics',
          'Clothing',
          'Home Appliances',
          'Books',
          'Toys',
        ],
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter product category';
          }
          return null;
        },
      ),
    );
  }
}
