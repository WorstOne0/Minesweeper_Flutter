import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
// Models
import '/models/cell.dart';
// Utils
import '/utils/context_extensions.dart';

class MinesweeperCell extends StatefulWidget {
  const MinesweeperCell({required this.cell, required this.isGameOver, super.key});

  final Cell cell;
  final bool isGameOver;

  @override
  State<MinesweeperCell> createState() => _MinesweeperCellState();
}

class _MinesweeperCellState extends State<MinesweeperCell> {
  Color handleCellColor() {
    return switch (widget.cell.cellState) {
      CellState.hidden => context.colorScheme.primary,
      CellState.flagged => context.colorScheme.surface,
      CellState.revealed => context.colorScheme.surface,
    };
  }

  double handleHeight() {
    return switch (widget.cell.cellState) {
      CellState.hidden => 40,
      CellState.flagged => 35,
      CellState.revealed => 0,
    };
  }

  BoxDecoration handleBoxDecoration() {
    return switch (widget.cell.cellState) {
      CellState.hidden => BoxDecoration(color: context.colorScheme.primary),
      CellState.flagged => BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
      CellState.revealed => BoxDecoration(color: context.colorScheme.primary),
    };
  }

  Color handleNumberColor() {
    return switch (widget.cell.adjacentMines) {
      1 => const Color(0xff1053E4),
      2 => const Color(0xff5ECE4F),
      3 => const Color(0xffE03616),
      4 => const Color(0xff682D63),
      5 => const Color(0xffAF9164),
      6 => const Color(0xffA14EBF),
      7 => const Color(0xff353531),
      8 => const Color(0xff121212),
      _ => Colors.white,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: handleCellColor(),
      child: Stack(
        children: [
          //
          Align(
            alignment: Alignment.center,
            child: widget.cell.cellState == CellState.revealed && !widget.cell.isMine
                ? Padding(
                    padding: const EdgeInsets.all(1),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: handleCellColor()),
                      child: Text(
                        widget.cell.adjacentMines != 0 ? "${widget.cell.adjacentMines}" : "",
                        style: TextStyle(
                          fontSize: 11,
                          color: handleNumberColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : null,
          ),

          //
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              height: handleHeight(),
              width: handleHeight(),
              duration: const Duration(milliseconds: 100),
              alignment: Alignment.center,
              decoration: handleBoxDecoration(),
              child: widget.cell.cellState == CellState.flagged
                  ? const Icon(Icons.flag, size: 20)
                  : null,
            ),
          ),

          // Game Over
          if (widget.isGameOver && widget.cell.isMine)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: handleCellColor()),
                  child: const Icon(Icons.bug_report, color: Colors.red, size: 24),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
