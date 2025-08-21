import 'package:flutter/material.dart';
import 'package:mini_wheelz/common/divider_widget/divider_widget.dart';
import 'package:mini_wheelz/common/header_text/header_text.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/ButtonWidget.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/category_selection_widget.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/description_widget.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/image_grid_column.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/price_quantity_widget.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/product_price_widget.dart';

final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Form(
            key: addProductFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                //Header Text
                const HeaderText(title: 'Add Product'),
                const SizedBox(height: 20),

                // Image Grid Column
                ImageGridColumn(),
                const SizedBox(height: 10),

                // Divider Widget
                DividerWidget(color: AppColors.divider),
                const SizedBox(height: 10),

                // Product Price Widget
                ProductPriceWidget(),
                const SizedBox(height: 10),

                // Product Price and Quantity Widget
                ProductPriceAndQTYWidget(),
                const SizedBox(height: 10),

                // Category Selection Widget
                CategorySelectionWidget(),
                const SizedBox(height: 20),

                // Description Widget
                DescriptionWidget(),
                const SizedBox(height: 20),

                //Button Widget
                ButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
