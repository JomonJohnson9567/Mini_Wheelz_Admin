import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';

class ImagePickGrid extends StatelessWidget {
  const ImagePickGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () async {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (ctx) {
                return Container(
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 36,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text('Camera'),
                          onTap: () {
                            Navigator.of(ctx).pop();
                            context.read<ProductBloc>().add(
                              const ProductImagePicked(fromCamera: true),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text('Gallery'),
                          onTap: () {
                            Navigator.of(ctx).pop();
                            context.read<ProductBloc>().add(
                              const ProductImagePicked(fromCamera: false),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.cardBackground,
            ),
            width: 120,
            height: 120,
            // color: AppColors.cardBackground,
            child: const Center(
              child: Icon(
                Icons.add_a_photo,
                size: 50,
                color: AppColors.iconPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
