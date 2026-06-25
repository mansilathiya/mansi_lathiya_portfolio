import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF6C63FF);
  static const primaryLight = Color(0xFF9D97FF);
  static const accent = Color(0xFFFF6584);
  static const accentGreen = Color(0xFF00E5A0);

  static const lightTeal = Color(0xFF00C896);

  // Light theme
  static const lightBg = Color(0xFFF8F9FF);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFEEEEF8);
  static const lightText = Color(0xFF1A1A2E);
  static const lightSubText = Color(0xFF5A5A7A);
  static const lightTextPrimary = Color(0xFF0D0B1A);
  static const lightTextSecondary = Color(0xFF5A5880);
  static const lightBorder = Color(0xFFDDDBFF);
  static const lightBorderGlow = Color(0xFFB8B4FF);

  // Dark theme
  static const darkBg = Color(0xFF0D0D1A);
  static const darkSurface = Color(0xFF16162A);
  static const darkCard = Color(0xFF1E1E35);
  static const darkText = Color(0xFFF0F0FF);
  static const darkSubText = Color(0xFFAAAAAA);
  static const darkTextPrimary = Color(0xFFF0F0FF);
  static const darkTextSecondary = Color(0xFF9090B0);
  static const darkBorder = Color(0xFF252535);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const lightCardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF3F2FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const darkCardGradient = LinearGradient(
    colors: [Color(0xFF14141F), Color(0xFF1A1A2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradient palette cycling per card
  static const kGradients = [
    LinearGradient(
      colors: [primary, Color(0xFF00D4FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFFF4D8D), primary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [accentGreen, Color(0xFF00D4FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFFFD60A), Color(0xFFFF4D8D)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFF3B82F6), accentGreen],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFAB5CF7), primary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  static LinearGradient gradientAt(int i) =>
      kGradients[i % kGradients.length];

  // Platform helpers
  static Color platformColor(String p) {
    if (p.contains('iOS') && p.contains('Android')) {
      return accentGreen;
    }
    if (p.contains('Web')) return accent;
    if (p.contains('iOS')) return const Color(0xFFAB5CF7);
    return  accentGreen;
  }
}

extension AppThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get bgColor => isDark ? AppColors.darkBg : AppColors.lightBg;
  Color get cardColor => isDark ? AppColors.darkCard : AppColors.lightCard;
  Color get borderColor =>
      isDark ? AppColors.darkBorder : AppColors.lightBorder;
  Color get textPrimary =>
      isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
  Color get textSecondary =>
      isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
  LinearGradient get cardGradient =>
      isDark ? AppColors.darkCardGradient : AppColors.lightCardGradient;
}
