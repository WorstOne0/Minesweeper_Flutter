import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:minesweeper/models/cell.dart';
// Utils
import '/utils/context_extensions.dart';

class MinesweeperCell extends StatefulWidget {
  const MinesweeperCell({required this.cell, super.key});

  final Cell cell;

  @override
  State<MinesweeperCell> createState() => _MinesweeperCellState();
}

class _MinesweeperCellState extends State<MinesweeperCell> {
  @override
  Widget build(BuildContext context) {
    bool isHidden = widget.cell.cellState == CellState.hidden;

    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: [
          //
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: switch (widget.cell.cellState) {
                  CellState.hidden => Text(""),
                  CellState.revealed => Text(
                      widget.cell.isMine ? "Bomb" : "${widget.cell.adjacentMines}",
                      style: TextStyle(color: Colors.white),
                    ),
                  CellState.flagged => Text(
                      "Flag",
                      style: TextStyle(color: Colors.white),
                    ),
                },
              ),
            ),
          ),

          //
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              height: isHidden ? 100 : 0,
              width: isHidden ? 100 : 0,
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.center,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
