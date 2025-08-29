import 'package:flutter/material.dart';

import 'package:mini_wheelz/common/buttons/button_signpage.dart';
import 'package:mini_wheelz/common/header_text/header_text.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';

import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/common/text_field/category_field/category_name_field.dart';
import 'package:mini_wheelz/presentation/add_category/widgets/description_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_category/bloc/category_bloc.dart';
import 'package:mini_wheelz/core/repositories/category_repository.dart';

// Global form key and controllers (you can manage these better via Bloc or DI)
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddCategoryPage extends StatelessWidget {
  const AddCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (_) => CategoryBloc(repository: CategoryRepository()),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const HeaderText(title: 'Add Category'),
                  const SizedBox(height: 20),
                  CategoryNameFiled(),

                  const SizedBox(height: 20),
                  DescriptionField(
                    controller:
                        TextEditingControllers.instance.descriptionController,

                    hintText: 'Category Description',

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category description';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  Builder(
                    builder: (innerContext) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: CustomButton(
                        text: 'Add Category',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final name = TextEditingControllers
                                .instance
                                .categorynameController
                                .text
                                .trim();
                            final description = TextEditingControllers
                                .instance
                                .descriptionController
                                .text
                                .trim();

                            innerContext.read<CategoryBloc>().add(
                              CategoryEvent.add(
                                name: name,
                                description: description,
                              ),
                            );

                            ScaffoldMessenger.of(innerContext).showSnackBar(
                              const SnackBar(content: Text('Category saved')),
                            );
                          }
                        },
                        backgroundColor: AppColors.buttonPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
