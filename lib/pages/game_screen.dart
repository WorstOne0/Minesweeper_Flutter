// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minesweeper/controllers/game_state_controller.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/cell.dart';

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
      child: Container(
        color: cell.adjacentMines == 0 && !cell.isMine ? Colors.red : Colors.blue,
        alignment: Alignment.center,
        child: switch (cell.cellState) {
          CellState.hidden => Text(""),
          CellState.revealed => Text(cell.isMine ? "Bomb" : "${cell.adjacentMines}"),
          CellState.flagged => Text("Flag"),
        },
      ),
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
                        color: Colors.amber,
                        alignment: Alignment.center,
                        child: LayoutGrid(
                          columnSizes:
                              List.generate(columns, (index) => getColumnsSize(context).px),
                          rowSizes: List.generate(rows, (index) => getColumnsSize(context).px),
                          columnGap: 5,
                          rowGap: 5,
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
