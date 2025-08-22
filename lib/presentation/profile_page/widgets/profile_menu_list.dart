import 'package:flutter/material.dart';
import 'package:mini_wheelz/presentation/order_history/pages/orders.dart';

import 'package:mini_wheelz/presentation/profile_page/widgets/profile_menu_item.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          icon: Icons.settings,
          title: 'Settings',
          onTap: () {
            _showComingSoonSnackBar(context);
          },
        ),
        ProfileMenuItem(
          icon: Icons.description,
          title: 'Terms and conditions',
          onTap: () {
            _showComingSoonSnackBar(context);
          },
        ),

        ProfileMenuItem(
          icon: Icons.shopping_bag,
          title: 'Orders',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => OrdersPage()),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showComingSoonSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Coming soon!'),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.snackbarSuccess,
      ),
    );
  }
}
