// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/buttons/button_signpage.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/add_product/pages/add_product.dart'; 

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: CustomButton(
          text: 'Add Product',
          onPressed: () {
            if (addProductFormKey.currentState!.validate()) {
              // Call Bloc event here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product added')),
              );
              Navigator.of(context).pop();
              // context.read<ProductBloc>().add(AddProduct(...));
            }
          },
          backgroundColor: AppColors.buttonPrimary,
        ),
      ),
    );
  }
}
