import 'package:flutter/material.dart';

class AppTheme {
  static const _backgroundColor = Color(0xFFFFFFFF); // ~60%
  static const _onBackgroundColor = Color(0xFF000000);
  static const _primaryColor = Color(0xFF000000); // ~30%
  static const _onPrimaryColor = Color(0xFFFFFFFF);
  static const _secondaryColor = Color(0xFF9E9E9E); // ~9%
  static const _tertiaryColor = Color(0xFF0B6CFF); // ~1%
  static const _onTertiaryColor = Color(0xFFFFFFFF);
  static const _errorContainerColor = Color(0xFFFF0000);

  final _colorScheme = const ColorScheme.light(
    background: _backgroundColor,
    onBackground: _onBackgroundColor,
    primary: _primaryColor,
    onPrimary: _onPrimaryColor,
    secondary: _secondaryColor,
    tertiary: _tertiaryColor,
    onTertiary: _onTertiaryColor,
    errorContainer: _errorContainerColor,
    error: _errorContainerColor,
    onError: _errorContainerColor,
    onErrorContainer: _errorContainerColor,
  );

  final _textTheme = const TextTheme(
    // displayLarge, displayMedium, displaySmall
    // headlineLarge, headlineMedium, headlineSmall
    // titleLarge, titleMedium, titleSmall
    // bodyLarge, bodyMedium, bodySmall
    // labelLarge, labelMedium, labelSmall
    headlineMedium: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: _primaryColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: _backgroundColor,
    ),
    labelLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: _secondaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: _secondaryColor,
    ),
  );

  final _inputDecorationTheme = const InputDecorationTheme(
    filled: true,
    fillColor: _backgroundColor,
    focusColor: _primaryColor,
    focusedBorder: InputBorder.none,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: _secondaryColor, width: 1),
    ),
    labelStyle: TextStyle(
      fontSize: 16,
      color: _secondaryColor,
    ),
    floatingLabelStyle: TextStyle(
      fontSize: 16,
      color: _tertiaryColor,
    ),
  );

  final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(_tertiaryColor),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      elevation: MaterialStateProperty.all(10),
      shape: MaterialStateProperty.all(
        const StadiumBorder(side: BorderSide.none),
      ),
    ),
  );

  final _textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      overlayColor: MaterialStateProperty.all(
        _tertiaryColor.withOpacity(0.1),
      ),
    ),
  );

  ThemeData get light {
    return ThemeData(
      textTheme: _textTheme,
      colorScheme: _colorScheme,
      inputDecorationTheme: _inputDecorationTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _primaryColor,
      ),
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
    );
  }
}
