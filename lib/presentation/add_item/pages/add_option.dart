// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mini_wheelz/presentation/add_item/widgets/add_category&product_widget.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/add_item/widgets/add_new_text.dart';
import 'package:mini_wheelz/presentation/add_item/widgets/header_container.dart';
import 'package:mini_wheelz/presentation/add_item/widgets/quick_stack.dart';

class AddOptionsDialog extends StatelessWidget {
  const AddOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dialogBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              HeaderContainer(),

              // Options Header
              AddNewText(),

              const SizedBox(height: 12),

              // Options
              AddCategoryAndProduct(),
              const SizedBox(height: 12),
              // Statistics Cards
              QuickStackItems(),
            ],
          ),
        ),
      ),
    );
  }
}
