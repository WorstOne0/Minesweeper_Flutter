// ignore_for_file: use_build_context_synchronously

// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
// Controllers
import '/controllers/google_ads_controller.dart';
// Pages
import '/pages/game_screen.dart';
// Widgets
import '/widgets/responsive/create_route.dart';
import '/widgets/my_snackbar.dart';
// Utils
import '/utils/context_extensions.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
  }

  void launchGithub() async {
    bool success = await launchUrl(Uri.parse('https://flutter.dev'));

    if (success) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          mySnackBar(Colors.red, Icons.error, "Failed to launch URL"),
        );
    }
  }

  Widget buildCard(String title, IconData icon, {bool isPrimary = false}) {
    return Card(
      elevation: 1,
      child: Container(
        width: 250,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isPrimary ? context.colorScheme.primary : null,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isPrimary ? Colors.black : null,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(color: isPrimary ? Colors.black : null, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "logo",
                      flightShuttleBuilder: (
                        flightContext,
                        animation,
                        flightDirection,
                        fromHeroContext,
                        toHeroContext,
                      ) {
                        return Material(color: Colors.transparent, child: toHeroContext.widget);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.bug_report,
                            size: 120,
                            color: context.colorScheme.primary,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "</> CodeSweeper",
                            style: TextStyle(
                              fontFamily: GoogleFonts.firaCode().fontFamily,
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    // buildCard("Resume", Icons.play_arrow, isPrimary: true),
                    GestureDetector(
                      onTap: () async {
                        await ref.read(googleAdsProvider.notifier).showAd();

                        Navigator.push(
                          context,
                          createRoute(const GameScreen(), "game_screen"),
                        );
                      },
                      child: buildCard("New Game", Icons.play_arrow),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            mySnackBar(Colors.red, Icons.error, "Coming Soon"),
                          );
                      },
                      child: buildCard("Best Times", Icons.access_time),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            mySnackBar(Colors.red, Icons.error, "Coming Soon"),
                          );
                      },
                      child: buildCard("Store", Icons.store),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.light_mode),
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.settings),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: launchGithub,
                  icon: const Icon(FontAwesomeIcons.github),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
