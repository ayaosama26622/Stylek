import 'package:final_project/core/constants/font_app.dart';
import 'package:final_project/core/styles/colors.dart';
import 'package:final_project/core/styles/text.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData get lightTheme => ThemeData(
    fontFamily: AppFonts.cairo,
    scaffoldBackgroundColor: AppColor.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.primaryPink,
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColor.whiteColor,
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      surfaceTintColor: Colors.transparent,
    ),
    dividerColor: Colors.transparent,
    dividerTheme: const DividerThemeData(color: AppColor.accentColor),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(60, 30),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.body.copyWith(color: const Color(0xFF9E9E9E)),
      fillColor: AppColor.accentColor,
      filled: true,

      prefixIconColor: AppColor.primaryPink,
      suffixIconColor: AppColor.primaryPink,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.primaryPink,
      unselectedItemColor: const Color(0xFF9E9E9E),
      backgroundColor: Colors.transparent,
      selectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      unselectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryPink,
      onSurface: const Color(0xFF121212),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppFonts.cairo,
    scaffoldBackgroundColor: const Color(0xFF000000),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF000000),
      elevation: 0,
      centerTitle: true,
      foregroundColor: AppColor.whiteColor,
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      surfaceTintColor: Colors.transparent,
    ),
    dividerColor: Colors.transparent,
    dividerTheme: const DividerThemeData(color: Color(0xFF3A3A3A)),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(60, 30),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.body.copyWith(color: const Color(0xFF9E9E9E)),
      fillColor: const Color(0xFF000000),
      filled: true,
      prefixIconColor: AppColor.primaryPink,
      suffixIconColor: AppColor.primaryPink,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.primaryPink,
      unselectedItemColor: const Color(0xFF9E9E9E),
      backgroundColor: const Color(0xFF000000),
      selectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      unselectedLabelStyle: TextStyles.caption1.copyWith(
        fontWeight: FontWeight.w600,
        height: 2,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryPink,
      brightness: Brightness.dark,
      surface: const Color(0xFF000000),
      onSurface: AppColor.whiteColor,
    ),
  );
}
