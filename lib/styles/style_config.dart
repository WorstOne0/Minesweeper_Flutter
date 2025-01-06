// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

// https://codelabs.developers.google.com/codelabs/flutter-boring-to-beautiful?hl=pt-br#4
// https://m3.material.io/theme-builder#/custom

TonalPalette toTonalPalette(int value) {
  final color = Hct.fromInt(value);
  return TonalPalette.of(color.hue, color.chroma);
}

TonalPalette primaryTonalP = toTonalPalette(const Color(0xFF385B3E).value);

// Color Scheme
// Generated Primary - 0xFF106D34
ColorScheme lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff30628c),
  surfaceTint: Color(0xff30628c),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffcfe5ff),
  onPrimaryContainer: Color(0xff001d33),
  secondary: Color(0xff52606f),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffd5e4f7),
  onSecondaryContainer: Color(0xff0e1d2a),
  tertiary: Color(0xff6e528a),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xfff0dbff),
  onTertiaryContainer: Color(0xff280d42),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfff7f9ff),
  onSurface: Color(0xff181c20),
  onSurfaceVariant: Color(0xff42474e),
  outline: Color(0xff72777f),
  outlineVariant: Color(0xffc2c7cf),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2d3135),
  inversePrimary: Color(0xff9ccbfb),
  primaryFixed: Color(0xffcfe5ff),
  onPrimaryFixed: Color(0xff001d33),
  primaryFixedDim: Color(0xff9ccbfb),
  onPrimaryFixedVariant: Color(0xff104a73),
  secondaryFixed: Color(0xffd5e4f7),
  onSecondaryFixed: Color(0xff0e1d2a),
  secondaryFixedDim: Color(0xffb9c8da),
  onSecondaryFixedVariant: Color(0xff3a4857),
  tertiaryFixed: Color(0xfff0dbff),
  onTertiaryFixed: Color(0xff280d42),
  tertiaryFixedDim: Color(0xffdab9f9),
  onTertiaryFixedVariant: Color(0xff553b71),
  surfaceDim: Color(0xffd8dae0),
  surfaceBright: Color(0xfff7f9ff),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff1f3f9),
  surfaceContainer: Color(0xffeceef4),
  surfaceContainerHigh: Color(0xffe6e8ee),
  surfaceContainerHighest: Color(0xffe0e2e8),
);

// Generated Primary - 0xFF84D994
ColorScheme darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff9ccbfb),
  surfaceTint: Color(0xff9ccbfb),
  onPrimary: Color(0xff003354),
  primaryContainer: Color(0xff104a73),
  onPrimaryContainer: Color(0xffcfe5ff),
  secondary: Color(0xffb9c8da),
  onSecondary: Color(0xff243240),
  secondaryContainer: Color(0xff3a4857),
  onSecondaryContainer: Color(0xffd5e4f7),
  tertiary: Color(0xffdab9f9),
  onTertiary: Color(0xff3e2459),
  tertiaryContainer: Color(0xff553b71),
  onTertiaryContainer: Color(0xfff0dbff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff101418),
  onSurface: Color(0xffe0e2e8),
  onSurfaceVariant: Color(0xffc2c7cf),
  outline: Color(0xff8c9199),
  outlineVariant: Color(0xff42474e),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe0e2e8),
  inversePrimary: Color(0xff30628c),
  primaryFixed: Color(0xffcfe5ff),
  onPrimaryFixed: Color(0xff001d33),
  primaryFixedDim: Color(0xff9ccbfb),
  onPrimaryFixedVariant: Color(0xff104a73),
  secondaryFixed: Color(0xffd5e4f7),
  onSecondaryFixed: Color(0xff0e1d2a),
  secondaryFixedDim: Color(0xffb9c8da),
  onSecondaryFixedVariant: Color(0xff3a4857),
  tertiaryFixed: Color(0xfff0dbff),
  onTertiaryFixed: Color(0xff280d42),
  tertiaryFixedDim: Color(0xffdab9f9),
  onTertiaryFixedVariant: Color(0xff553b71),
  surfaceDim: Color(0xff101418),
  surfaceBright: Color(0xff36393e),
  surfaceContainerLowest: Color(0xff0b0e12),
  surfaceContainerLow: Color(0xff181c20),
  surfaceContainer: Color(0xff1c2024),
  surfaceContainerHigh: Color(0xff272a2f),
  surfaceContainerHighest: Color(0xff323539),
);

// Default Design
ShapeBorder get shapeMedium => RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));

// Themes
CardTheme cardTheme(bool isDark) {
  return CardTheme(
    elevation: 0,
    shape: shapeMedium,
    color: isDark ? null : Colors.white,
    surfaceTintColor: !isDark ? null : Colors.white,
  );
}

AppBarTheme appBarTheme(ColorScheme colors, bool isDark) {
  return AppBarTheme(
    elevation: 0,
    backgroundColor: isDark ? colors.surface : colors.primary,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    ),

    // MD3
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
  );
}

TabBarTheme tabBarTheme(ColorScheme colors) {
  return TabBarTheme(
    labelColor: colors.secondary,
    unselectedLabelColor: colors.onSurfaceVariant,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: colors.secondary, width: 2),
      ),
    ),
  );
}

BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
  return BottomAppBarTheme(color: colors.surface, elevation: 0);
}

BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
  return BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    backgroundColor: colors.surface,
    selectedItemColor: colors.primary,
  );
}

FloatingActionButtonThemeData floatingActionButtonTheme(ColorScheme colors) {
  return FloatingActionButtonThemeData(
    backgroundColor: colors.primary,
    foregroundColor: Colors.white,
  );
}

DialogTheme dialogTheme(ColorScheme colors) {
  return DialogTheme(
    backgroundColor: colors.surface,
    surfaceTintColor: Colors.transparent,
  );
}

ButtonThemeData buttonThemeData() {
  return const ButtonThemeData(height: 48);
}

BottomSheetThemeData bottomSheetThemeData(ColorScheme colors) {
  return BottomSheetThemeData(
    backgroundColor: colors.surface,
    surfaceTintColor: Colors.transparent,
  );
}

// Light
ThemeData light() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    typography: Typography.material2021(colorScheme: lightColorScheme),
    appBarTheme: appBarTheme(lightColorScheme, false),
    cardTheme: cardTheme(false),
    dialogTheme: dialogTheme(lightColorScheme),
    // bottomAppBarTheme: bottomAppBarTheme(lightColorScheme),
    bottomNavigationBarTheme: bottomNavigationBarTheme(lightColorScheme),
    // tabBarTheme: tabBarTheme(lightColorScheme),
    floatingActionButtonTheme: floatingActionButtonTheme(lightColorScheme),
    buttonTheme: buttonThemeData(),
    bottomSheetTheme: bottomSheetThemeData(lightColorScheme),
  );
}

// Dark
ThemeData dark() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    typography: Typography.material2021(colorScheme: darkColorScheme),
    appBarTheme: appBarTheme(darkColorScheme, true),
    cardTheme: cardTheme(true),
    dialogTheme: dialogTheme(darkColorScheme),
    // bottomAppBarTheme: bottomAppBarTheme(darkColorScheme),
    bottomNavigationBarTheme: bottomNavigationBarTheme(darkColorScheme),
    // tabBarTheme: tabBarTheme(darkColorScheme),
    scaffoldBackgroundColor: darkColorScheme.surface,
    floatingActionButtonTheme: floatingActionButtonTheme(darkColorScheme),
    buttonTheme: buttonThemeData(),
    bottomSheetTheme: bottomSheetThemeData(darkColorScheme),
  );
}
