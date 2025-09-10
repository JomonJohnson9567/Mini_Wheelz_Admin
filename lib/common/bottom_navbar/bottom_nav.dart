import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/presentation/add_item/pages/add_option.dart';
import 'package:mini_wheelz/presentation/home/pages/home.dart';
import 'package:mini_wheelz/presentation/nottification/pages/notifications.dart';
import 'package:mini_wheelz/presentation/product_view/product_viewpage.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:mini_wheelz/presentation/profile_page/page/profie_page.dart';
import 'package:mini_wheelz/common/bottom_navbar/bloc/navigation_cubit.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';

class BottomNavBar extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final user;
  const BottomNavBar({super.key, this.user});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Track the previous tab

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return PersistentTabView(
            context,
            controller: PersistentTabController(
              initialIndex: state.selectedIndex,
            ),
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineToSafeArea: true,
            navBarStyle: NavBarStyle.style1,
            navBarHeight: 80, // Adjust this value to change the height
            backgroundColor: AppColors.bottomNavBackground,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            onItemSelected: (index) {
              if (index == 2) {
                // Store the current tab before showing dialog
                // Add button clicked - show popup
                AddOptionsDialog();
              } else {
                context.read<NavigationCubit>().changeTab(index);
              }
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildScreens() => [
    const HomePage(),
    const ProductViewpage(),
    AddOptionsDialog(), // Placeholder for Add button (shows popup instead)
    const NotificationsPage(),
    Profilescreen(
      user: FirebaseAuth.instance.currentUser,
    ), // Replace null with actual user if available
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: AppColors.tabHome,
      inactiveColorPrimary: AppColors.bottomNavInactive,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_cart),
      title: ("Products"),
      activeColorPrimary: AppColors.tabProducts,
      inactiveColorPrimary: AppColors.bottomNavInactive,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.add_box),
      title: ("Add"),
      activeColorPrimary: AppColors.tabAdd,
      inactiveColorPrimary: AppColors.bottomNavInactive,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.notifications),
      title: ("Notification"),
      activeColorPrimary: AppColors.tabNotifications,
      inactiveColorPrimary: AppColors.bottomNavInactive,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: ("Profile"),
      activeColorPrimary: AppColors.tabProfile,
      inactiveColorPrimary: AppColors.bottomNavInactive,
    ),
  ];
}
