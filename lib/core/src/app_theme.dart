import 'package:flutter/material.dart';
import 'package:flutter_animation/core/src/app_colors.dart';

class AppTheme {
  AppTheme._();

  static final defaultTheme = ThemeData(
    primaryColor: AppColors.primary,
    backgroundColor: AppColors.white,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.primary,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColors.primary,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: AppColors.primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: AppColors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    )
  );
}
