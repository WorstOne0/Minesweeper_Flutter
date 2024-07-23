enum CellState {
  hidden,
  revealed,
  flagged,
}

class Cell {
  late int row;
  late int column;

  late CellState cellState;
  late bool isMine;
  late int adjacentMines;

  Cell({
    required this.row,
    required this.column,
    required this.cellState,
    required this.isMine,
    required this.adjacentMines,
  });

  Cell copyWith({int? row, int? column, CellState? cellState, bool? isMine, int? adjacentMines}) {
    return Cell(
      row: row ?? this.row,
      column: column ?? this.column,
      cellState: cellState ?? this.cellState,
      isMine: isMine ?? this.isMine,
      adjacentMines: adjacentMines ?? this.adjacentMines,
    );
  }
}
