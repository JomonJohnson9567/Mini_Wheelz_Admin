// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mini_wheelz/presentation/add_category/pages/add_category.dart';
import 'package:mini_wheelz/presentation/add_item/widgets/build_option_tile_widget.dart';
import 'package:mini_wheelz/presentation/add_product/pages/add_product.dart';

class AddCategoryAndProduct extends StatelessWidget {
  const AddCategoryAndProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          buildOptionTile(
            context: context,
            icon: Icons.category_rounded,
            title: 'Add Category',
            subtitle: 'Create a new product category',
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddCategoryPage()),
              );
            },
          ),
          const SizedBox(height: 12),
          buildOptionTile(
            context: context,
            icon: Icons.inventory_2_rounded,
            title: 'Add Product',
            subtitle: 'Add a new product',
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddProductPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
