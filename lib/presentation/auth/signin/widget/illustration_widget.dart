import 'package:flutter/material.dart';

class IllustrationWidget extends StatelessWidget {
  const IllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Characters illustration image
          Positioned(
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Image(
                  image: NetworkImage(
                    'https://cdn1.iconfinder.com/data/icons/characters-and-objects/512/e-commerce_character_builder___shopping_ecommerce_commerce_cart_purchase_bag_sale.png',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
