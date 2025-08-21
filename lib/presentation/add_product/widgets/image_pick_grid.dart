import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class ImagePickGrid extends StatelessWidget {
  const ImagePickGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print('Image selection tapped');
            }
            // Handle image selection
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
