// Dart
import 'dart:math';
// Models
import '/models/cell.dart';

enum ClickResponse {
  win,
  lose,
  keepPlaying,
}

class Board {
  late int rowsCount;
  late int columnsCount;
  List<List<Cell>> cells = [];

  late int totalMines;
  late int flags;

  late bool isFirstClick;

  late bool isGameWin;
  late bool isGameOver;

  Board({required this.rowsCount, required this.columnsCount, required this.totalMines}) {
    createBoard(rowsCount, columnsCount, totalMines);

    flags = 0;

    isFirstClick = true;

    isGameWin = false;
    isGameOver = false;
  }

  //
  Cell getCell(int row, int column) => cells[row][column];
  void changeCell(int row, int column, Cell cell) => cells[row][column] = cell;

  //
  void createBoard(int rowsCount, int columnsCount, int totalMines) {
    // Create the Grid
    for (int row = 0; row < rowsCount; row++) {
      List<Cell> rowCells = [];

      for (int column = 0; column < columnsCount; column++) {
        rowCells.add(
          Cell(
            row: row,
            column: column,
            cellState: CellState.hidden,
            isMine: false,
            adjacentMines: 0,
          ),
        );
      }

      cells.add(rowCells);
    }
  }

  void placeMines(int rowClear, int columnClear) {
    // Place the mines
    for (int mine = 0; mine < totalMines; mine++) {
      int row = Random().nextInt(rowsCount);
      int column = Random().nextInt(columnsCount);

      Cell cell = cells[row][column];

      // Check if the current cell is within the cleared square
      if ((row >= rowClear - 1 && row <= rowClear + 1) &&
          (column >= columnClear - 1 && column <= columnClear + 1)) {
        mine--;
        continue;
      }

      if (!cell.isMine) {
        cell = cell.copyWith(isMine: true);
        changeCell(row, column, cell);
      } else {
        mine--;
      }
    }

    // Count the number of adjacent mines
    for (int row = 0; row < rowsCount; row++) {
      for (int column = 0; column < columnsCount; column++) {
        Cell cell = cells[row][column];

        if (!cell.isMine) {
          int adjacentMines = 0;
          for (int rowOffset = -1; rowOffset <= 1; rowOffset++) {
            for (int columnOffset = -1; columnOffset <= 1; columnOffset++) {
              if (rowOffset == 0 && columnOffset == 0) continue;
              if (row + rowOffset < 0 || row + rowOffset >= rowsCount) continue;
              if (column + columnOffset < 0 || column + columnOffset >= columnsCount) continue;
              if (cells[row + rowOffset][column + columnOffset].isMine) adjacentMines++;
            }
          }

          cell = cell.copyWith(adjacentMines: adjacentMines);
          changeCell(row, column, cell);
        }
      }
    }
  }

  bool checkWin() {
    for (int row = 0; row < rowsCount; row++) {
      for (int column = 0; column < columnsCount; column++) {
        Cell cell = cells[row][column];

        if (cell.isMine && cell.cellState == CellState.hidden) {
          return false;
        }
      }
    }

    return true;
  }

  bool checkLose() {
    for (int row = 0; row < rowsCount; row++) {
      for (int column = 0; column < columnsCount; column++) {
        Cell cell = cells[row][column];

        if (cell.isMine && cell.cellState == CellState.revealed) {
          return true;
        }
      }
    }

    return false;
  }

  void handleClick(int row, int column) {
    if (isFirstClick) {
      placeMines(row, column);
      isFirstClick = false;
    }

    Cell cell = cells[row][column];

    if (cell.cellState == CellState.flagged) return;

    if (cell.isMine) {
      isGameOver = true;
      return;
    }

    switch (cell.cellState) {
      case CellState.hidden:
        revealCell(row, column);
        break;

      case CellState.revealed:
        int flaggedAdjacentCells = 0;

        for (int rowOffset = -1; rowOffset <= 1; rowOffset++) {
          for (int columnOffset = -1; columnOffset <= 1; columnOffset++) {
            if (rowOffset == 0 && columnOffset == 0) continue;
            if (row + rowOffset < 0 || row + rowOffset >= rowsCount) continue;
            if (column + columnOffset < 0 || column + columnOffset >= columnsCount) continue;
            if (cells[row + rowOffset][column + columnOffset].cellState == CellState.flagged) {
              flaggedAdjacentCells++;
            }
          }
        }

        if (flaggedAdjacentCells == cell.adjacentMines) {
          for (int rowOffset = -1; rowOffset <= 1; rowOffset++) {
            for (int columnOffset = -1; columnOffset <= 1; columnOffset++) {
              if (rowOffset == 0 && columnOffset == 0) continue;
              if (row + rowOffset < 0 || row + rowOffset >= rowsCount) continue;
              if (column + columnOffset < 0 || column + columnOffset >= columnsCount) continue;

              revealCell(row + rowOffset, column + columnOffset);
            }
          }
        }

        changeCell(row, column, cell);

        break;

      case CellState.flagged:
        break;
    }

    isGameOver = checkLose();
    isGameWin = checkWin();
  }

  void revealCell(int row, int column) {
    Cell cell = cells[row][column];

    if (cell.cellState == CellState.flagged || cell.cellState == CellState.revealed) return;

    cell = cell.copyWith(cellState: CellState.revealed);
    changeCell(row, column, cell);

    if (cell.adjacentMines == 0) {
      for (int rowOffset = -1; rowOffset <= 1; rowOffset++) {
        for (int columnOffset = -1; columnOffset <= 1; columnOffset++) {
          if (rowOffset == 0 && columnOffset == 0) continue;
          if (row + rowOffset < 0 || row + rowOffset >= rowsCount) continue;
          if (column + columnOffset < 0 || column + columnOffset >= columnsCount) continue;

          revealCell(row + rowOffset, column + columnOffset);
        }
      }
    }

    isGameOver = checkLose();
    isGameWin = checkWin();
  }

  void setFlag(int row, int column) {
    Cell cell = cells[row][column].copyWith(cellState: CellState.flagged);
    flags++;

    changeCell(row, column, cell);
    isGameWin = checkWin();
  }

  void removeFlag(int row, int column) {
    Cell cell = cells[row][column].copyWith(cellState: CellState.hidden);
    flags--;

    changeCell(row, column, cell);
  }
}
