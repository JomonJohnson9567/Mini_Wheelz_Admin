import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/text_field/select_category_field.dart/select_category_field.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_category/bloc/category_bloc.dart';
import 'package:mini_wheelz/core/repositories/category_repository.dart';

class CategorySelectionWidget extends StatelessWidget {
  const CategorySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hasBloc = context.read<CategoryBloc?>();
    final child = BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final items = state.categories.map((c) => c.name).toList();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SelectCategoryField(
            controller:
                TextEditingControllers.instance.productCategoryController,
            fillcolor: AppColors.textPrimary,
            hintText: state.status == CategoryStatus.loading
                ? 'Loading categories...'
                : (items.isEmpty ? 'No categories found' : 'Select Category'),
            hintStyle: TextStyle(color: AppColors.textHint),
            dropdownItems: items.isEmpty ? null : items,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select product category';
              }
              return null;
            },
          ),
        );
      },
    );

    if (hasBloc == null) {
      return BlocProvider(
        create: (_) =>
            CategoryBloc(repository: CategoryRepository())
              ..add(const CategoryEvent.load()),
        child: child,
      );
    }

    return child;
  }
}
