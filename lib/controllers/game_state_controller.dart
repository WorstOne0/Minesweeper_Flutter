// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minesweeper/models/board.dart';
import 'package:minesweeper/models/cell.dart';
import 'package:minesweeper/services/storage/secure_storage.dart';

@immutable
class GameStateState {
  const GameStateState({required this.board});

  final Board? board;

  GameStateState copyWith({Board? board}) {
    return GameStateState(board: board ?? this.board);
  }
}

class GameProviderController extends StateNotifier<GameStateState> {
  GameProviderController({required this.ref, required this.storage})
      : super(const GameStateState(board: null));

  Ref ref;
  SecureStorage storage;

  void createNewGame(int rowsCount, int columnsCount, int totalMines) {
    state = state.copyWith(
      board: Board(rowsCount: rowsCount, columnsCount: columnsCount, totalMines: totalMines),
    );
  }

  //
  Cell getCell(int row, int column) => state.board!.getCell(row, column);

  void handleClick(int row, int column) {
    Board board = state.board!;
    board.handleClick(row, column);

    state = state.copyWith(board: board);
  }

  void setFlag(int row, int column) {
    Board board = state.board!;
    board.setFlag(row, column);

    state = state.copyWith(board: board);
  }
}

final gameProvider = StateNotifierProvider<GameProviderController, GameStateState>((ref) {
  return GameProviderController(
    ref: ref,
    storage: ref.watch(secureStorageProvider),
  );
});
