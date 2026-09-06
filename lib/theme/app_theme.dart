import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsLight.background,
    colorScheme: const ColorScheme.light(
      primary: AppColorsLight.primary,
      secondary: AppColorsLight.secondary,
      surface: AppColorsLight.surface,
      onSurface: AppColorsLight.onSurface,
    ),
    cardTheme: const CardThemeData(
      color: AppColorsLight.surface,
      elevation: 1,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColorsDark.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColorsDark.primary,
      secondary: AppColorsDark.secondary,
      surface: AppColorsDark.surface,
      onSurface: AppColorsDark.onSurface,
    ),
    cardTheme: const CardThemeData(
      color: AppColorsDark.surface,
      elevation: 1,
    ),
  );
}
