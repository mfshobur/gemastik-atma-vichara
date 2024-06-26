import 'package:atma_vichara_gemastik/core/constants.dart';
import 'package:flutter/material.dart';

const _white = Color(0xffffffff);
const _black = Color(0xff1E1E1E);
const _grey = Color(0xffA8A8A8);

const _primary = Color(0xff1551ED);
const _secondary = Color(0xff0188ED);
const _tertiary = Color(0xffAD8E55);

class AppTheme {
  ThemeData theme = ThemeData(
    // fontFamily: "SegoeUI",
    colorScheme: const ColorScheme.light(
      primary: _primary,
      secondary: _secondary,
      tertiary: _tertiary,
      onPrimary: _white,
      onSecondary: Color(0xffE0F2FF),
      onTertiary: _white,
      background: _white,
      onBackground: _black,
      surface: _white,
      surfaceVariant: Color(0xffE1EBFF),
      onSurface: _black,
      onSurfaceVariant: _grey,
      shadow: _grey,
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0.0,
      surfaceTintColor: _white,
      elevation: 5,
      shadowColor: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: _secondary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(_primary),
        foregroundColor: MaterialStateProperty.all<Color>(_white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16,
            fontWeight: kFontweightSemiBold,
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _primary.withOpacity(0.2);
            }
            return _primary;
          },
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            color: _primary,
            width: 2.0,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(_white),
        foregroundColor: MaterialStateProperty.all<Color>(_primary),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16,
            fontWeight: kFontweightSemiBold,
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return _primary.withOpacity(0.2);
            }
            return _primary;
          },
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    ),
    checkboxTheme: const CheckboxThemeData(
      side: BorderSide(
        color: kDarkGrey,
        width: 2.0,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: _secondary,
    ),
  );
}
