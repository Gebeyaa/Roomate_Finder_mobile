
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 186, 73, 7);
  static const Color secondaryColor = Color.fromARGB(255, 28, 206, 238);
  static const Color appBarColor = Color(0xFF0A6FBA);
  static const Color textDark = Color(0xFF14142A);
  static const Color textMedium = Color(0xFF4E4866);
  static const Color textLight = Color(0xFF6E7191);
  static const Color accentBlue = Color(0xFF0A6FBA);
  static const Color accentCyan = Color(0xFF09DBE9);
  static const Color backgroundLight = Color(0xFFEFF0F6);
  static const Color backgroundLighter = Color(0xFFF7F7FC);
  static const Color backgroundWhite = Color(0xFFFAF9F9);

  static const String fontFamily = 'Roboto';

  static TextTheme get textTheme => TextTheme(
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: textDark,
    ),

    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: textDark,
    ),

    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textDark,
    ),

    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: textDark,
    ),

    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: textMedium,
    ),

    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: textMedium,
    ),
    // Paragraph 03
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: textLight,
    ),
  );

  static ThemeData get lightTheme => ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundWhite,
      background: backgroundLighter,
    ),
    textTheme: textTheme,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: backgroundWhite,

    appBarTheme: AppBarTheme(
      backgroundColor: appBarColor,
      elevation: 0,
      titleTextStyle: textTheme.displayMedium?.copyWith(
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white), 
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: backgroundLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}
