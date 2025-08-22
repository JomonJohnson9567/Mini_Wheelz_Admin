import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mini_wheelz/presentation/profile_page/widgets/edit_profile_button.dart';
import 'package:mini_wheelz/presentation/profile_page/widgets/profile_header.dart';
import 'package:mini_wheelz/presentation/profile_page/widgets/profile_menu_list.dart';
import 'package:mini_wheelz/presentation/profile_page/widgets/sign_out_button.dart';

import 'package:mini_wheelz/core/theme/app_colors.dart';

class Profilescreen extends StatelessWidget {
  final User? user;
  const Profilescreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Dark theme background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const ProfileHeader(),

                EditProfileButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => EditProfilePage()),
                    // );
                    // showSwitchAccountDialog(context);
                  },
                ),
                const SizedBox(height: 20),

                // Sign Out Button
                buildSignOutButton(context),

                const SizedBox(height: 40),

                // Menu Items List
                const ProfileMenuList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
