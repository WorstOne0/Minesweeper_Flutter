// ignore_for_file: use_build_context_synchronously

// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Pages
import '/pages/home.dart';
// Widgets
import '/widgets/responsive/create_route.dart';

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
        color: Colors.amber,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("LOL")],
          ),
        ),
      ),
    );
  }
}
