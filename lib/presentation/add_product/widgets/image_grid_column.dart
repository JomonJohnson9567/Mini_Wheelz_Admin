import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_product/bloc/product_bloc.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/image_pick_grid.dart';

class ImageGridColumn extends StatelessWidget {
  const ImageGridColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final images = state.images;
        return Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                for (int i = 0; i < images.length && i < 4; i++)
                  _ImageTile(file: images[i], index: i),
                if (images.length < 4) const ImagePickGrid(),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _ImageTile extends StatelessWidget {
  const _ImageTile({required this.file, required this.index});
  final File file;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(file, width: 120, height: 120, fit: BoxFit.cover),
        ),
        Positioned(
          right: 4,
          top: 4,
          child: InkWell(
            onTap: () =>
                context.read<ProductBloc>().add(ProductImageRemoved(index)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
