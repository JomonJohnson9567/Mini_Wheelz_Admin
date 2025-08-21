import 'package:flutter/material.dart';
import 'package:mini_wheelz/presentation/add_item/widgets/build_state_card.dart';
import 'package:mini_wheelz/presentation/add_item/widgets/out_of_stockcard.dart';

class QuickStackItems extends StatelessWidget {
  const QuickStackItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Statistics Header
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Quick Stats',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Statistics Row
          Row(
            children: [
              // Categories Count
              Expanded(
                child: buildStatCard(
                  count: '12',
                  label: 'Categories',
                  icon: Icons.category_rounded,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Products Count
              Expanded(
                child: buildStatCard(
                  count: '248',
                  label: 'Products',
                  icon: Icons.inventory_2_rounded,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Out of Stock Card (Full Width)
          buildOutOfStockCard(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
