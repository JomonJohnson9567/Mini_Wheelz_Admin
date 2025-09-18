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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_category/bloc/category_bloc.dart';
import 'package:mini_wheelz/core/repositories/category_repository.dart';
import 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';
import 'package:mini_wheelz/core/repositories/product_repository.dart';
import 'package:mini_wheelz/core/controllers/textediting_controllers.dart';

final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // very important
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  CategoryBloc(repository: CategoryRepository())
                    ..add(const CategoryEvent.load()),
            ),
            BlocProvider(
              create: (_) => ProductBloc(repository: ProductRepository()),
            ),
          ],
          child: BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state.status == ProductStatus.loading) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else if (state.status == ProductStatus.success) {
                Navigator.of(context, rootNavigator: true).maybePop();
                TextEditingControllers.instance.productNameController.clear();
                TextEditingControllers.instance.productPriceController.clear();
                TextEditingControllers.instance.productQuantityController
                    .clear();
                TextEditingControllers.instance.productDescriptionController
                    .clear();
                TextEditingControllers.instance.productCategoryController
                    .clear();
                context.read<ProductBloc>().add(const ProductReset());
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Product added')),
                  );
              } else if (state.status == ProductStatus.error) {
                Navigator.of(context, rootNavigator: true).maybePop();
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        state.errorMessage ?? 'Failed to add product',
                      ),
                    ),
                  );
              }
            },
            child: SingleChildScrollView(
              // Adjust bottom padding dynamically when keyboard opens
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Form(
                key: addProductFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const HeaderText(title: 'Add Product'),
                    const SizedBox(height: 20),
                    const ImageGridColumn(),
                    const SizedBox(height: 10),
                    DividerWidget(color: AppColors.divider),
                    const SizedBox(height: 10),
                    const ProductPriceWidget(),
                    const SizedBox(height: 10),
                    const ProductPriceAndQTYWidget(),
                    const SizedBox(height: 10),
                    const CategorySelectionWidget(),
                    const SizedBox(height: 20),
                    const DescriptionWidget(),
                    const SizedBox(height: 20),
                    const ButtonWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
