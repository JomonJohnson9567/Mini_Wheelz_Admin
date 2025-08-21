
import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/presentation/add_category/widgets/description_field.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DescriptionField(
        controller: TextEditingControllers
            .instance
            .productproductDescriptionController,
        hintText: 'Product Description',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter product description';
          }
          return null;
        },
      ),
    );
  }
}
