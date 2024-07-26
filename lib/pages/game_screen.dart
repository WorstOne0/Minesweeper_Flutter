// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minesweeper/controllers/game_state_controller.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/widgets/minesweeper_cell.dart';
import 'package:minesweeper/widgets/neumorphism_container.dart';

// In the classic Minesweeper game, key elements include mines, numbers indicating how many mines are adjacent, and the grid itself. Here are some programming-related alternatives for these elements:

// Mines (Bombs):

// Bugs: Instead of mines, you could use the concept of "bugs" in a codebase. Players would need to avoid "bugs" in the same way they avoid mines.
// Numbers (Clues):

// Lines of Code: The numbers could represent lines of code, with the number indicating how many lines of "buggy" code are adjacent.
// Warning Messages: Alternatively, numbers could represent the count of adjacent "warning messages" indicating potential issues in the code.
// Grid (Board):

// Code Files: The grid could represent different code files or modules in a project, with each cell being a separate file.
// Servers or Systems: In a more complex theme, the grid could represent a network of servers or systems, where each cell is a server and the goal is to maintain uptime by avoiding "bugs."
// Flags:

// Fixes: Instead of flags to mark mines, players could place "fixes" or "patches" to mark potential bug locations.
// Empty Cells:

// Clean Code: Cells without bugs could be referred to as "clean code" or "optimized code."
// These changes can help create a programming-themed Minesweeper game, making it more relatable for those interested in coding and software development.

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool isLoading = true;

  late TransformationController transformationController;
  //
  // int rows = 34, columns = 20;
  int rows = 16, columns = 10;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();

    transformationController = TransformationController();
    // final scaleMatrix = Matrix4.identity()..scale(0.3);
    // transformationController = TransformationController(scaleMatrix);

    createNewGame();
  }

  void createNewGame() async {
    await Future.delayed(const Duration(milliseconds: 50));
    ref.read(gameProvider.notifier).createNewGame(rows, columns, 20);

    setState(() => isLoading = false);
  }

  double getColumnsSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // return width / columns;
    return 40;
  }

  List<Widget> buildGameBoard() {
    List<Widget> gameBoard = [];

    for (int row = 0; row < rows; row++) {
      List<Widget> rowWidgets = [];

      for (int column = 0; column < columns; column++) {
        rowWidgets.add(buildGameCell(row, column));
      }

      gameBoard.addAll(rowWidgets);
    }

    return gameBoard;
  }

  Widget buildGameCell(int row, int column) {
    Cell cell = ref.read(gameProvider.notifier).getCell(row, column);

    return GestureDetector(
      onTap: () => ref.read(gameProvider.notifier).handleClick(row, column),
      onLongPress: () => ref.read(gameProvider.notifier).setFlag(row, column),
      child: MinesweeperCell(cell: cell),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(gameProvider);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Board? board = ref.watch(gameProvider).board;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (!isLoading) Text((board?.isGameLose ?? false) ? "Perdeu Otario" : "TO jogando"),
            // Padding(
            //   padding: const EdgeInsets.all(30),
            //   child: GestureDetector(
            //     onTap: () => setState(() => isPressed = !isPressed),
            //     child: NeumorphicTheme(
            //       themeMode: ThemeMode.light,
            //       theme: NeumorphicThemeData(
            //         baseColor: Colors.green,
            //         lightSource: LightSource.topLeft,
            //       ),
            //       child: NeumorphismContainer(isPressed: isPressed),
            //     ),
            //   ),
            // ),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: InteractiveViewer(
                      maxScale: 5,
                      minScale: 0.2,
                      boundaryMargin: EdgeInsets.symmetric(
                        vertical: height * 1.5,
                        horizontal: width * 1.5,
                      ),
                      transformationController: transformationController,
                      constrained: false,
                      child: Container(
                        color: Colors.black,
                        child: LayoutGrid(
                          columnSizes:
                              List.generate(columns, (index) => getColumnsSize(context).px),
                          rowSizes: List.generate(rows, (index) => getColumnsSize(context).px),
                          columnGap: -0.2,
                          rowGap: -0.2,
                          children: buildGameBoard(),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
