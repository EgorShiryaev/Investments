import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _backgroundColor = Color(0xFFFFFFFF); // ~60%
  static const _onBackgroundColor = Color(0xFF000000);
  static const _primaryColor = Color(0xFF000000); // ~30%
  static const _onPrimaryColor = Color(0xFFFFFFFF);
  static const _secondaryColor = Color(0xFF9E9E9E); // ~9%
  static const _tertiaryColor = Color(0xFF0B6CFF); // ~1%
  static const _onTertiaryColor = Color(0xFFFFFFFF);
  static const _errorContainerColor = Color(0xFFFF0000);
  static const _onErrorContainerColor = Color(0xFFFFFFFF);
  static const _surfaceColor = Color(0xFFFFFFFF);

  static const _elevation = 8.0;

  ColorScheme get _colorScheme {
    return const ColorScheme.light(
      background: _backgroundColor,
      onBackground: _onBackgroundColor,
      primary: _primaryColor,
      onPrimary: _onPrimaryColor,
      secondary: _secondaryColor,
      tertiary: _tertiaryColor,
      onTertiary: _onTertiaryColor,
      errorContainer: _errorContainerColor,
      error: _errorContainerColor,
      onError: _onErrorContainerColor,
      onErrorContainer: _onErrorContainerColor,
      surface: _surfaceColor,
    );
  }

  final TextStyle _defaultTextStyle = GoogleFonts.inter();

  TextTheme get _textTheme {
    return TextTheme(
      displayMedium: _defaultTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: _onBackgroundColor,
      ),
      headlineMedium: _defaultTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: _secondaryColor,
      ),
      titleMedium: _defaultTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _primaryColor,
      ),
      bodyMedium: _defaultTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _secondaryColor,
      ),
      labelMedium: _defaultTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _primaryColor,
      ),
    );
  }

  InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: _backgroundColor,
      focusColor: _primaryColor,
      focusedBorder: InputBorder.none,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: _secondaryColor, width: 1),
      ),
      labelStyle: _defaultTextStyle.copyWith(
        fontSize: 16,
        color: _secondaryColor,
      ),
      floatingLabelStyle: _defaultTextStyle.copyWith(
        fontSize: 16,
        color: _tertiaryColor,
      ),
    );
  }

  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(_tertiaryColor),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        elevation: MaterialStateProperty.all(_elevation),
        shape: MaterialStateProperty.all(
          const StadiumBorder(side: BorderSide.none),
        ),
        textStyle: MaterialStateProperty.all(
          _defaultTextStyle.copyWith(
            color: _onTertiaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
    );
  }

  DialogTheme get _dialogTheme {
    return DialogTheme(
      backgroundColor: _backgroundColor,
      elevation: _elevation,
      titleTextStyle: _textTheme.headlineSmall,
      contentTextStyle: _textTheme.labelMedium,
    );
  }

  BottomNavigationBarThemeData get _bottomNavigationBarTheme {
    const iconSize = 32.0;
    const fontSize = 12.0;
    return BottomNavigationBarThemeData(
      selectedIconTheme: const IconThemeData(size: iconSize),
      unselectedIconTheme: const IconThemeData(size: iconSize),
      selectedItemColor: _onTertiaryColor,
      unselectedItemColor: _onTertiaryColor.withOpacity(0.5),
      backgroundColor: _tertiaryColor,
      elevation: _elevation,
      selectedLabelStyle: _defaultTextStyle.copyWith(fontSize: fontSize),
      unselectedLabelStyle: _defaultTextStyle.copyWith(fontSize: fontSize),
      type: BottomNavigationBarType.fixed,
    );
  }

  static const cardContentPadding =
      EdgeInsets.symmetric(vertical: 10, horizontal: 15);

  static const pagePadding = EdgeInsets.symmetric(horizontal: 16);

  CardTheme get _cardTheme {
    return CardTheme(
      clipBehavior: Clip.hardEdge,
      color: _surfaceColor,
      elevation: _elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.zero,
    );
  }

  IconThemeData get _iconTheme {
    return const IconThemeData(
      color: _primaryColor,
      size: 24,
    );
  }

  ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: _backgroundColor,
      textTheme: _textTheme,
      colorScheme: _colorScheme,
      inputDecorationTheme: _inputDecorationTheme,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _primaryColor,
      ),
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      dialogTheme: _dialogTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      cardTheme: _cardTheme,
      iconTheme: _iconTheme,
    );
  }
}
