// ignore_for_file: use_build_context_synchronously

// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// Pages
import '/pages/home.dart';
// Widgets
import '/widgets/responsive/create_route.dart';
// Utils
import '/utils/context_extensions.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    asyncInit();
  }

  void asyncInit() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(context, createRoute(const Home(), "login.dart"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset("assets/images/splash_screen_background.png").image,
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: Hero(
            tag: "logo",
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bug_report,
                  size: 140,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(height: 5),
                Text(
                  "</> CodeSweeper",
                  style: TextStyle(fontFamily: GoogleFonts.firaCode().fontFamily, fontSize: 26),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
