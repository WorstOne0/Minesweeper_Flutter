// Flutter Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
// Firebase
import '/firebase_options.dart';
// Pages
import '/pages/splash_screen.dart';
// Services
import '/services/navigator_provider.dart';
import '/services/storage/secure_storage.dart';
// Styles
import '/styles/style_config.dart';
// Widgets
import '/widgets/responsive/reponsive_widget.dart';

void main() async {
  // Flutter initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Enviroment Variables - https://pub.dev/packages/flutter_config
  await FlutterConfig.loadEnvVariables();

  // Firebase initial configuration
  await Firebase.initializeApp(
    // name: "code_sweeper",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Firebase catch erros
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  // Initialize Google Ads
  await MobileAds.instance.initialize();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openLazyBox("wikidadosBox");

  // *** RIVERPOD ***
  // Startup (https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup/)
  // 1. Create a ProviderContainer
  final container = ProviderContainer(observers: []);
  // Dark Mode
  bool isDark = await container.read(secureStorageProvider).readString("dark_mode") == "true";
  isDark = true;

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
