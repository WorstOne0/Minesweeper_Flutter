// Dart
import 'dart:async';
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Models
import '/models/board.dart';
import '/models/cell.dart';
// Services
import '/services/storage/secure_storage.dart';

@immutable
class GameStateState {
  const GameStateState({required this.board, required this.time});

  final Board? board;
  final Duration time;

  GameStateState copyWith({Board? board, Duration? time}) {
    return GameStateState(
      board: board ?? this.board,
      time: time ?? this.time,
    );
  }
}

class GameProviderController extends StateNotifier<GameStateState> {
  GameProviderController({required this.ref, required this.storage})
      : super(const GameStateState(board: null, time: Duration.zero));

  Ref ref;
  SecureStorage storage;

  Timer? timer;

  void createNewGame(int rowsCount, int columnsCount, int totalMines) {
    state = state.copyWith(
      board: Board(rowsCount: rowsCount, columnsCount: columnsCount, totalMines: totalMines),
    );
  }

  Cell getCell(int row, int column) => state.board!.getCell(row, column);

  void handleClick(int row, int column) {
    Board board = state.board!;
    board.handleClick(row, column);

    state = state.copyWith(board: board);
  }

  void setFlag(int row, int column) {
    Board board = state.board!;
    Cell cell = board.getCell(row, column);

    if (cell.cellState == CellState.hidden) {
      board.setFlag(row, column);
      state = state.copyWith(board: board);

      return;
    }

    if (cell.cellState == CellState.flagged) {
      board.removeFlag(row, column);
      state = state.copyWith(board: board);

      return;
    }
  }

  void startTimer() => timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (!state.board!.isGameWin) stopTimer();

          if (!state.board!.isGameOver) {
            state = state.copyWith(time: state.time + const Duration(seconds: 1));
          } else {
            stopTimer();
          }
        },
      );

  void stopTimer() {
    timer?.cancel();
    state = state.copyWith(time: Duration.zero);
  }
}

final gameProvider = StateNotifierProvider<GameProviderController, GameStateState>((ref) {
  return GameProviderController(
    ref: ref,
    storage: ref.watch(secureStorageProvider),
  );
});
