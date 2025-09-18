import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/presentation/add_category/widgets/description_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DescriptionField(
        controller:
            TextEditingControllers.instance.productDescriptionController,
        hintText: 'Product Description',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter product description';
          }
          return null;
        },
        onChanged: (value) => context.read<ProductBloc>().add(
          ProductFieldChanged(description: value),
        ),
      ),
    );
  }
}
