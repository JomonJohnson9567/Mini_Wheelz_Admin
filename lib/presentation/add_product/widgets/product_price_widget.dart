import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/text_field/product_price_field.dart/product_price_field.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';

class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ProductPriceField(
        controller: TextEditingControllers.instance.productNameController,
        fillcolor: AppColors.textPrimary,
        hintText: 'Product Name',
        hintStyle: TextStyle(color: AppColors.textHint),
        isPassword: false,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter product name';
          }
          return null;
        },
        onChanged: (value) =>
            context.read<ProductBloc>().add(ProductFieldChanged(name: value)),
      ),
    );
  }
}
