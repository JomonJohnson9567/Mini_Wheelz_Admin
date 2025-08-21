// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppColors {
 
  AppColors._();
  static const Color whitecolor = Color.fromARGB(255, 255, 255, 255);
  static const Color signupbkgColor = Color.fromARGB(255, 252, 252, 252);
   static const Color primary = Color(0xFF4CAF50);
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFF81C784);

   static const Color background = Color(0xFF1E1E1E);
  static const Color surface = Color(0xFF2D2D2D);
  static const Color cardBackground = Color(0xFF3A3A3A);

   static const Color darkBackground = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF2D2D2D);
  static const Color darkCard = Color(0xFF3A3A3A);

   static const Color textFieldBackground = Color(0xFF222222);
  static const Color textFieldBorder = Color(0xFF404040);
  static const Color textFieldFocusedBorder = Color(0xFF4CAF50);
  static const Color textFieldErrorBorder = Color(0xFFE57373);

   static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textHint = Color(0xFF808080);
  static const Color textError = Color(0xFFE57373);

   static const Color bottomNavBackground = Color(0xFF131313);
  static const Color bottomNavActive = Color(0xFF4CAF50);
  static const Color bottomNavInactive = Color(0xFF808080);

   static const Color tabHome = Color(0xFF4CAF50);
  static const Color tabProducts = Color(0xFFED1A1A);
  static const Color tabAdd = Color(0xFFCCEA07);
  static const Color tabNotifications = Color(0xFFFB5102);
  static const Color tabProfile = Color(0xFF098C98);

   static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF64B5F6);

   static const Color buttonPrimary = Color(0xFF4CAF50);
  static const Color buttonSecondary = Color(0xFF757575);
  static const Color buttonDisabled = Color(0xFF424242);

   static const Color dialogBackground = Color(0xFF1E1E1E);
  static const Color dialogSurface = Color(0xFF2D2D2D);

  static const Color gradientStart = Color(0xFF6366F1);
  static const Color gradientEnd = Color(0xFF8B5CF6);
  static const Color gradientGreenStart = Color(0xFF10B981);
  static const Color gradientGreenEnd = Color(0xFF059669);
  static const Color gradientBlueStart = Color(0xFF3B82F6);
  static const Color gradientBlueEnd = Color(0xFF1D4ED8);

  static const Color borderLight = Color(0xFF404040);
  static const Color borderMedium = Color(0xFF606060);
  static const Color borderDark = Color(0xFF808080);

  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

   static const Color overlayLight = Color(0x1AFFFFFF);
  static const Color overlayMedium = Color(0x33FFFFFF);
  static const Color overlayDark = Color(0x4DFFFFFF);

   static const Color divider = Color(0xFF404040);
  static const Color dividerLight = Color(0xFF2A2A2A);

   static const Color iconPrimary = Color(0xFFFFFFFF);
  static const Color iconSecondary = Color(0xFFB3B3B3);
  static const Color iconDisabled = Color(0xFF606060);

   static const Color loadingPrimary = Color(0xFF4CAF50);
  static const Color loadingSecondary = Color(0xFF81C784);

   static const Color snackbarSuccess = Color(0xFF4CAF50);
  static const Color snackbarError = Color(0xFFE57373);
  static const Color snackbarInfo = Color(0xFF64B5F6);
  static const Color snackbarWarning = Color(0xFFFFB74D);
 
  static const Color customDark = Color(0xFF131313);
  static const Color customGrey = Color(0xFF808080);
  static const Color customLightGrey = Color(0xFFB3B3B3);
  static const Color customWhite = Color(0xFFFFFFFF);
  static const Color customBlack = Color(0xFF000000);

   static const Color materialGreen = Color(0xFF4CAF50);
  static const Color materialRed = Color(0xFFE57373);
  static const Color materialBlue = Color(0xFF64B5F6);
  static const Color materialOrange = Color(0xFFFFB74D);
  static const Color materialPurple = Color(0xFFBA68C8);
  static const Color materialTeal = Color(0xFF4DB6AC);
 
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

 
  static Color darken(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  
  static Color lighten(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }
}
