// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minesweeper/pages/game_screen.dart';
import 'package:minesweeper/widgets/responsive/create_route.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
            onTap: () {
              Navigator.push(context, createRoute(GameScreen(), "game_screen"));
            },
            child: Text("Home")),
      ),
    );
  }
}
