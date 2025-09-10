import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_wheelz/common/divider_widget/divider_widget.dart';
import 'package:mini_wheelz/core/theme/app_colors.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_cubit.dart';
import 'package:mini_wheelz/presentation/auth/bloc/cubit/authentication_state.dart';
import 'package:mini_wheelz/presentation/home/widgets/earning_card_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section - Responsive
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32.0 : 20.0,
                    vertical: isTablet ? 32.0 : 24.0,
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          String? photoUrl;
                          if (state is AuthAuthenticated) {
                            photoUrl = state.user.photoURL;
                          }

                          final avatar = CircleAvatar(
                            radius: isTablet ? 32 : 24,
                            backgroundColor: AppColors.surface,
                            backgroundImage:
                                (photoUrl != null && photoUrl.isNotEmpty)
                                ? NetworkImage(photoUrl)
                                : null,
                            child: (photoUrl == null || photoUrl.isEmpty)
                                ? Icon(
                                    Icons.person,
                                    size: isTablet ? 32 : 24,
                                    color: Colors.grey,
                                  )
                                : null,
                          );

                          return InkWell(
                            borderRadius: BorderRadius.circular(
                              isTablet ? 36 : 28,
                            ),
                            onTap: () {
                              // navigate to profile
                            },
                            child: avatar,
                          );
                        },
                      ),

                      // Center: App logo centered using Expanded + Center
                      Expanded(
                        child: Center(
                          child: Container(
                            height: isTablet ? 64 : 48,
                            width: isTablet ? 96 : 72,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('lib/assets/app_logo.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                DividerWidget(color: AppColors.divider),

                // Earnings Section - Made responsive and scrollable
                Padding(
                  padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: isLargeScreen
                            ? 800
                            : (isTablet ? 600 : double.infinity),
                        minHeight: isTablet ? 300 : 200,
                      ),
                      padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                      decoration: BoxDecoration(
                        color: AppColors.panel,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Earnings',
                            style: TextStyle(
                              fontSize: isTablet ? 42 : 34,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: isTablet ? 24 : 16),

                          // First Earning Card
                          EarningCard(
                            titleTop: 'Current Week',
                            titleBottom: 'Earnings:',
                            amount: '29,086.59',
                            cardColor: AppColors.card,
                            accent: AppColors.accent,
                            subtle: AppColors.subtle,
                            isTablet: isTablet,
                          ),

                          SizedBox(height: isTablet ? 20 : 16),

                          // Second Earning Card
                          EarningCard(
                            titleTop: "Today's",
                            titleBottom: 'Earnings:',
                            amount: '3,420.59',
                            cardColor: AppColors.card,
                            accent: AppColors.accent,
                            subtle: AppColors.subtle,
                            isTablet: isTablet,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Products',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: isLargeScreen
                          ? 800
                          : (isTablet ? 600 : double.infinity),
                      minHeight: isTablet ? 300 : 200,
                    ),
                    padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
                    decoration: BoxDecoration(
                      color: AppColors.panel,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              'https://miniaturetoyshop.com/wp-content/uploads/2024/12/Star-Model-RWB-993-Cyberpunk-Silver.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: isTablet ? 12 : 8),
                        Row(
                          children: [
                            Text(
                              'Star Model RWB 993 \n Cyberpunk Silver',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: isTablet ? 22 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '₹ 1,000',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: isTablet ? 22 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (kDebugMode) {
                          print('view all products');
                        }
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: isTablet ? 22 : 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: isTablet ? 22 : 18,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
                SizedBox(height: isTablet ? 32 : 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
