import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasi_care/core/theme/app_colors.dart';

abstract class Ktheme {
  static final appTheme = ThemeData(
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Color(AppColors.background)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Color(AppColors.primary)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Color(AppColors.primary), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Color(AppColors.error)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Color(AppColors.error), width: 2.0),
      ),
      labelStyle: TextStyle(color: Color(AppColors.textPrimary)),
      hintStyle: TextStyle(color: Color(AppColors.textSecondary)),
      filled: true,
      fillColor: Color(AppColors.background),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
    ),
    colorScheme: ColorScheme(
      primary: Color(AppColors.primary),
      secondary: Color(AppColors.secondary),
      surface: Color(AppColors.accent),
      error: Color(AppColors.error),
      onPrimary: Color(AppColors.background),
      onSecondary: Color(AppColors.textPrimary),
      onSurface: Color(AppColors.textPrimary),
      onError: Color(AppColors.background),
      brightness: Brightness.light,
    ),
    primaryColor: Color(AppColors.primary),
    scaffoldBackgroundColor: Color(AppColors.background),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Color(AppColors.textPrimary),
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(AppColors.textPrimary),
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(AppColors.textPrimary),
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(AppColors.textPrimary),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Color(AppColors.textPrimary),
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Color(AppColors.textPrimary),
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(AppColors.textPrimary),
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Color(AppColors.textPrimary),
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color(AppColors.textPrimary),
      ),
    ),
    cardColor: Color(AppColors.primary),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(AppColors.background),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(AppColors.textPrimary),
      ),
      elevation: 0,
    ),
  );
}
