// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Controllers
import '/controllers/game_state_controller.dart';
// Models
import '/models/board.dart';
import '/models/cell.dart';
// Widgets
import '/widgets/minesweeper_cell.dart';

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
  int rows = 16, columns = 10;
  bool firstClick = false;

  @override
  void initState() {
    super.initState();

    transformationController = TransformationController();

    createNewGame();
  }

  void createNewGame() async {
    await Future.delayed(const Duration(milliseconds: 50));
    ref.read(gameProvider.notifier).createNewGame(rows, columns, 20);

    alignGameBoard();

    setState(() => isLoading = false);
  }

  void alignGameBoard() {
    Matrix4 matrix = Matrix4.identity();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double paddedWidth = width - 100;
    double paddedHeight = height - kToolbarHeight - 100;
    double columnsSize = columns * 40;

    if (columnsSize > paddedWidth) {
      matrix.scale(paddedWidth / columnsSize);
      matrix.translate(60.0, paddedHeight / 4);
    }

    transformationController.value = matrix;
  }

  void focusOnPoint(int row, int column) {
    Matrix4 matrix = transformationController.value;

    matrix.scale(1.1);
    matrix.translate(-(column - 1) * 40.0, -(row - 1) * 40.0);

    transformationController.value = matrix;

    setState(() {});
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
      onTap: () {
        if (!firstClick) {
          // focusOnPoint(row, column);

          setState(() => firstClick = true);
        }

        ref.read(gameProvider.notifier).handleClick(row, column);
      },
      onLongPress: () => ref.read(gameProvider.notifier).setFlag(row, column),
      child: MinesweeperCell(cell: cell),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(gameProvider);

    Board? board = ref.watch(gameProvider).board;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (!isLoading) Text((board?.isGameLose ?? false) ? "Perdeu Otario" : "TO jogando"),
            isLoading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double width = constraints.maxHeight;
                        double height = constraints.maxHeight;

                        return InteractiveViewer(
                          maxScale: 4,
                          minScale: 0.4,
                          boundaryMargin: EdgeInsets.symmetric(
                            vertical: height * 0.5,
                            horizontal: width * 0.5,
                          ),
                          transformationController: transformationController,
                          constrained: false,
                          child: Container(
                            color: Colors.black,
                            child: LayoutGrid(
                              columnSizes: List.generate(columns, (index) => 40.px),
                              rowSizes: List.generate(rows, (index) => 40.px),
                              columnGap: -0.2,
                              rowGap: -0.2,
                              children: buildGameBoard(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
