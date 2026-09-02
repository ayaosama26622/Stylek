import 'package:flutter/material.dart';

abstract class AppColor {
  static const Color primaryPink = Color(0XFFFFD6F7);
  static const Color primaryBlue = Color(0XFFD5E8FF);

  // Pastel tints for the profile menu section cards.
  static const Color profilePersonalInfoBg = Color(0xFFFCE0F6);
  static const Color profileOrdersBg = Color(0xFFE7DFFB);
  static const Color profileControlsBg = Color(0xFFDCEAFC);

  static const Color whiteColor = Color(0XFFFFFFFF);
  static const Color accentColor = Color(0xFFE6EFF9);
  static const Color errorColor = Color(0xFFDA1B1B);
  static const Color blue = Color(0xFF9AC6FF);

  // Light-mode values are exactly what this project shipped with
  // originally. Dark-mode values are the brighter variants tuned later
  // so text/icons stay readable against the app's near-black dark theme.
  static const Color _greyColorLight = Color(0xFF6E6E6E);
  static const Color _greyColorDark = Color(0xFF9E9E9E);
  static const Color _darkColorLight = Color(0XFF121212);
  static const Color _darkColorDark = Color(0xFF282828);

  static Color greyColor(BuildContext context) =>
      isDark(context) ? _greyColorDark : _greyColorLight;

  static Color darkColor(BuildContext context) =>
      isDark(context) ? _darkColorDark : _darkColorLight;

  /// Clearly-visible muted grey for de-emphasized text (e.g. a struck-
  /// through old price) that still needs to read against dark surfaces —
  /// unlike [darkColor]/[greyColor], which are close to black and can
  /// disappear against a dark card. Light mode matches the original
  /// muted-grey look this text always had.
  static Color mutedVisible(BuildContext context) =>
      isDark(context) ? const Color(0xFF9E9E9E) : const Color(0xFF6E6E6E);

  static const List<Color> gradientColors = [
    Color(0xFFF8B4F1),
    Color(0xFFA2C9FF),
  ];

  static const List<Color> backgroundGradientColors = [
    Color(0xFFFFD6F7),
    Color(0xFFFFD6F7),
    Color(0xFFD5E8FF),
    Color(0xFFD5E8FF),
  ];

  static const List<Color> textred = [Color(0xFFB43234), Color(0xFF660F10)];

  // Dark-mode counterparts for the app's shared page chrome.
  static const List<Color> darkBackgroundGradientColors = [
    Color(0xFF000000),
    Color(0xFF000000),
    Color(0xFF000000),
    Color(0xFF000000),
  ];
  static const Color darkSurfaceColor = Color(0xFF282828);

  static const Color shimmerBaseLight = Color(0xFFE0E0E0);
  static const Color shimmerHighlightLight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF2A2A2A);
  static const Color shimmerHighlightDark = Color(0xFF3A3A3A);

  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  /// The page background gradient, swapped for a dark-mode variant when
  /// the current theme brightness is dark.
  static List<Color> pageGradient(BuildContext context) {
    return isDark(context) ? darkBackgroundGradientColors : backgroundGradientColors;
  }

  /// Card / sheet surface color: white in light mode, dark grey in dark mode.
  static Color surface(BuildContext context) {
    return isDark(context) ? darkSurfaceColor : whiteColor;
  }

  /// Primary text/icon color: dark in light mode, white in dark mode.
  static Color onSurface(BuildContext context) {
    return isDark(context) ? whiteColor : darkColor(context);
  }

  /// Shimmer/skeleton loader colors, swapped for dark mode.
  static Color shimmerBase(BuildContext context) {
    return isDark(context) ? shimmerBaseDark : shimmerBaseLight;
  }

  static Color shimmerHighlight(BuildContext context) {
    return isDark(context) ? shimmerHighlightDark : shimmerHighlightLight;
  }

  /// Muted/secondary text or icon color for content sitting ON a card
  /// surface. Uses the same light/dark split as [greyColor].
  static Color mutedOnCard(BuildContext context) {
    return greyColor(context);
  }
}
