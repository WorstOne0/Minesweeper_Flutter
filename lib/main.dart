import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minesweeper/pages/splash_screen.dart';
import 'package:minesweeper/services/navigator_provider.dart';
import 'package:minesweeper/services/storage/secure_storage.dart';
import 'package:minesweeper/styles/style_config.dart';
import 'package:minesweeper/widgets/responsive/reponsive_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  // Flutter initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openLazyBox("wikidadosBox");

  // *** RIVERPOD ***
  // Startup (https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup/)
  // 1. Create a ProviderContainer
  final container = ProviderContainer(observers: []);
  // Dark Mode
  bool isDark = await container.read(secureStorageProvider).readString("dark_mode") == "true";

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(isDark: isDark),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeProvider(
      initTheme: isDark ? dark() : light(),
      duration: const Duration(milliseconds: 500),
      // GetX package - adds useful funcionalities
      builder: (_, theme) => MaterialApp(
        title: 'Minesweeper',
        debugShowCheckedModeBanner: false,
        theme: theme,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          breakpoints: [
            const Breakpoint(start: 0, end: 500, name: MOBILE),
            const Breakpoint(start: 501, end: 1024, name: TABLET),
            const Breakpoint(start: 1025, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: child!,
        ),
        // Always start at Splash Screen
        home: const ResponsiveWidget(child: SplashScreen()),
        // // Support PT-BR in dates
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        // (https://github.com/rrousselGit/riverpod/issues/268)
        navigatorKey: ref.watch(navigatorKeyProvider),
      ),
    );
  }
}
