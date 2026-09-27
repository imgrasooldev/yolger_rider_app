import 'package:flutter/material.dart';

extension AppColors on ColorScheme {
  // Brand colors
  static const Color primaryColor = Color(0xFF16A34A);
  static const Color secondaryColor = Color(0xFF22C55E);

  // Light theme
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF0F172A);
  static const Color textSecondaryColor = Color(0xFF666666);
  static const Color borderColor = Color(0xFFE0E0E0);

  // Functional colors
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF59E0B);

  static const Color cardLightColor = Color(0xFFFFFFFF);
  static const Color cardDarkColor = Color(0xFF1A1A1A);

  // Dark theme
  static const Color darkPrimaryColor = Color(0xFF16A34A);
  static const Color darkSecondaryColor = Color(0xFF22C55E);
  static const Color darkBackgroundColor = Color(0xFF0F172A);
  static const Color darkCardColor = Color(0xFF1A1A1A);
  static const Color darkTextColor = Color(0xFFFFFFFF);
  static const Color darkTextSecondaryColor = Color(0xFFB4B4B4);
  static const Color darkBorderColor = Color(0xFF3C3C41);

  static const Color darkErrorColor = Color(0xFFE57373);
  static const Color darkSuccessColor = Color(0xFF64C850);
  static const Color darkWarningColor = Color(0xFFF59E0B);

  // Accent colors
  static const Color accentYellow = Color(0xFFF59E0B);
  static const Color accentOrange = Color(0xFFF59E0B);
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentPurple = Color(0xFFB478FF);
  static const Color accentBlue = Color(0xFF78C8FF);

  static const Color greylightBackground = Color(0xFFF5F5F5);

  Color get oppColorChange =>
      brightness == Brightness.dark ? cardLightColor : darkBackgroundColor;

  Color get sameColorChange =>
      brightness == Brightness.dark ? darkBackgroundColor : cardLightColor;

  Color? get ratingColorChange =>
      brightness == Brightness.dark
          ? Colors.grey[700]
          : Colors.grey[200];
}