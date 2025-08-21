import 'package:flutter/material.dart';
import 'package:mini_wheelz/presentation/add_product/widgets/image_pick_grid.dart';

class ImageGridColumn extends StatelessWidget {
  const ImageGridColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ImagePickGrid(), ImagePickGrid()],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ImagePickGrid(), ImagePickGrid()],
        ),
      ],
    );
  }
}
