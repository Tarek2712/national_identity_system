import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: GoogleFonts.cairoTextTheme().apply(
        bodyColor: AppColors.lightText,
        displayColor: AppColors.lightText,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: GoogleFonts.cairoTextTheme().apply(
        bodyColor: AppColors.darkText,
        displayColor: AppColors.darkText,
      ),
    );
  }
}