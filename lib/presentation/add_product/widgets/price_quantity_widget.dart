import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/text_field/product_price_field.dart/product_price_field.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class ProductPriceAndQTYWidget extends StatelessWidget {
  const ProductPriceAndQTYWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: ProductPriceField(
              controller:
                  TextEditingControllers.instance.productPriceController,
              fillcolor: AppColors.textPrimary,
              hintText: 'Product Price',
              hintStyle: TextStyle(color: AppColors.textHint),
              isPassword: false,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product price';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ProductPriceField(
              controller:
                  TextEditingControllers.instance.productQuantityController,
              fillcolor: AppColors.textPrimary,
              hintText: 'Product Quantity',
              hintStyle: TextStyle(color: AppColors.textHint),
              isPassword: false,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter product quantity';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
