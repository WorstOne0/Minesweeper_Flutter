// Flutter Packages
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
  primary: Color(0xFF385B3E),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF9FF6AE),
  onPrimaryContainer: Color(0xFF00210A),
  secondary: Color(0xFF506351),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD3E8D2),
  onSecondaryContainer: Color(0xFF0E1F12),
  tertiary: Color(0xFF39656D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFBDEAF4),
  onTertiaryContainer: Color(0xFF001F25),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  surface: Color(0xFFFAFAFA),
  onSurface: Color(0xFF1A1C19),
  onSurfaceVariant: Color(0xFF414941),
  outline: Color(0xFF727970),
  onInverseSurface: Color(0xFFF0F1EC),
  inverseSurface: Color(0xFF2E312E),
  inversePrimary: Color(0xFF84D994),
  shadow: Color(0xFF000000),
  surfaceTint: Colors.transparent,
  outlineVariant: Color(0xFFC1C9BE),
  scrim: Color(0xFF000000),
);

// Generated Primary - 0xFF84D994
ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(primaryTonalP.get(40)),
  onPrimary: const Color(0xFF003917),
  primaryContainer: const Color(0xFF005224),
  onPrimaryContainer: const Color(0xFF9FF6AE),
  secondary: const Color(0xFFB7CCB6),
  onSecondary: const Color(0xFF233425),
  secondaryContainer: const Color(0xFF394B3B),
  onSecondaryContainer: const Color(0xFFD3E8D2),
  tertiary: const Color(0xFFA1CED8),
  onTertiary: const Color(0xFF00363E),
  tertiaryContainer: const Color(0xFF204D55),
  onTertiaryContainer: const Color(0xFFBDEAF4),
  error: const Color(0xFF93000A),
  errorContainer: const Color(0xFF93000A),
  onError: const Color(0xFF690005),
  onErrorContainer: const Color(0xFFFFDAD6),
  surface: const Color(0xFF1A1C19),
  onSurface: const Color(0xFFE2E3DE),
  onSurfaceVariant: const Color(0xFFC1C9BE),
  outline: const Color(0xFF8B9389),
  onInverseSurface: const Color(0xFF1A1C19),
  inverseSurface: const Color(0xFFE2E3DE),
  inversePrimary: const Color(0xFF106D34),
  shadow: const Color(0xFF000000),
  surfaceTint: const Color(0xFF84D994),
  outlineVariant: const Color(0xFF414941),
  scrim: const Color(0xFF000000),
);

// Default Design
ShapeBorder get shapeMedium => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

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
        bottom: BorderSide(
          color: colors.secondary,
          width: 2,
        ),
      ),
    ),
  );
}

BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
  return BottomAppBarTheme(
    color: colors.surface,
    elevation: 0,
  );
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
  return const ButtonThemeData(
    height: 48,
    textTheme: ButtonTextTheme.accent,
  );
}

BottomSheetThemeData bottomSheetThemeData(ColorScheme colors) {
  return BottomSheetThemeData(
    backgroundColor: colors.surface,
    surfaceTintColor: Colors.transparent,
  );
}

// Light
ThemeData light() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightColorScheme.surface,
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
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkColorScheme.surface,
    colorScheme: darkColorScheme,
    typography: Typography.material2021(colorScheme: darkColorScheme),
    appBarTheme: appBarTheme(darkColorScheme, true),
    cardTheme: cardTheme(true),
    dialogTheme: dialogTheme(darkColorScheme),
    // bottomAppBarTheme: bottomAppBarTheme(darkColorScheme),
    bottomNavigationBarTheme: bottomNavigationBarTheme(darkColorScheme),
    // tabBarTheme: tabBarTheme(darkColorScheme),
    floatingActionButtonTheme: floatingActionButtonTheme(darkColorScheme),
    buttonTheme: buttonThemeData(),
    bottomSheetTheme: bottomSheetThemeData(darkColorScheme),
  );
}
