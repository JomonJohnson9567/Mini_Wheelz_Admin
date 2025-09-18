// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/buttons/button_signpage.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/add_product/pages/add_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/presentation/add_category/bloc/category_bloc.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: CustomButton(
          text: 'Add Product',
          onPressed: () {
            if (addProductFormKey.currentState!.validate()) {
              final ctrls = TextEditingControllers.instance;
              final name = ctrls.productNameController.text.trim();
              final price =
                  double.tryParse(ctrls.productPriceController.text) ?? 0;
              final qty =
                  int.tryParse(ctrls.productQuantityController.text) ?? 0;
              final desc = ctrls.productDescriptionController.text.trim();
              final selectedCategoryName = ctrls.productCategoryController.text
                  .trim();

              final categories = context.read<CategoryBloc>().state.categories;
              final match = categories.firstWhere(
                (c) => c.name == selectedCategoryName,
                orElse: () => (categories.isNotEmpty
                    ? categories.first
                    : categories.singleWhere((_) => false)),
              );
              final categoryId = match.id;

              if (categoryId.isEmpty) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Please select a valid category'),
                    ),
                  );
                return;
              }

              context.read<ProductBloc>().add(
                ProductFieldChanged(
                  name: name,
                  price: price,
                  quantity: qty,
                  description: desc,
                  categoryId: categoryId,
                ),
              );

              context.read<ProductBloc>().add(const ProductSubmitted());
            }
          },
          backgroundColor: AppColors.buttonPrimary,
        ),
      ),
    );
  }
}
