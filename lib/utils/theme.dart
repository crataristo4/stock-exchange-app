import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// custom theme
ThemeData kApplyCustomTheme(BuildContext context) {
  final fontFamily = GoogleFonts.spaceGrotesk();
  final textTheme = GoogleFonts.spaceGroteskTextTheme();
  return ThemeData.light(useMaterial3: true).copyWith(
    textTheme: textTheme.copyWith(),
    colorScheme: _kApplyColorScheme(context),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: _kApplyIconTheme(context),
      actionsIconTheme: _kApplyIconTheme(context),
    ),
  );
}

IconThemeData _kApplyIconTheme(BuildContext context) =>
    const IconThemeData(color: Color(0xff0a7447));

ColorScheme _kApplyColorScheme(BuildContext context) {
  var colorScheme = const ColorScheme.light().copyWith(
    primary: const Color(0xff0a7447),
    secondary: const Color(0xff0a7447),
    surface: const Color(0xfff1f3f5),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.deepOrange,
  );
  return colorScheme;
}
