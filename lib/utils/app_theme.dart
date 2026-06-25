import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';

abstract final class AppTheme {
  static final ThemeData light = _base(Brightness.light).copyWith(
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.lightSurface,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText,
    ),
    cardColor: AppColors.lightCard,
    dividerColor: AppColors.primary.withValues(alpha: 0.2),
  );

  static final ThemeData dark = _base(Brightness.dark).copyWith(
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.darkSurface,
    ),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    ),
    cardColor: AppColors.darkCard,
    dividerColor: AppColors.primary.withValues(alpha: 0.3),
  );

  static ThemeData _base(Brightness brightness) => ThemeData(
    brightness: brightness,
    useMaterial3: true,
    primaryColor: AppColors.primary,
  );
}
