// import 'dart:async';
// import 'package:flutter_stockfish_plugin/stockfish.dart';
// import 'package:flutter_stockfish_plugin/stockfish_state.dart';

// class ChessEngine {
//   late Stockfish _stockfish;
//   late StreamSubscription _stockfishOutputSubsciption;
//   late double _timeMs;
//   late String _nextMove;

//   ChessEngine() {
//     _stockfish = Stockfish();
//     _stockfishOutputSubsciption =
//         _stockfish.stdout.listen(_readStockfishOutput);
//     _timeMs = 1000.0;
//     _nextMove = '';
//     _doStartStockfish();
//   }

//   Future<void> _doStartStockfish() async {
//     await Future.delayed(const Duration(milliseconds: 1100));
//     _stockfish.stdin = 'uci';
//     await Future.delayed(const Duration(milliseconds: 3000));
//     _stockfish.stdin = 'isready';
//   }

//   void _readStockfishOutput(String output) {
//     if (output.startsWith('bestmove')) {
//       final parts = output.split(' ');
//       _nextMove = parts[1];
//     }
//   }

//   void updateThinkingTime(double newValue) {
//     _timeMs = newValue;
//   }

//   void computeNextMove(String fen) {
//     _stockfish.stdin = 'position fen ${fen.trim()}';
//     _stockfish.stdin = 'go movetime ${_timeMs.toInt()}';
//   }

//   String get bestMove => _nextMove;
//   int get timeInMs => _timeMs.toInt();

//   void stopStockfish() async {
//     if (_stockfish.state.value == StockfishState.disposed ||
//         _stockfish.state.value == StockfishState.error) {
//       return;
//     }
//     _stockfishOutputSubsciption.cancel();
//     _stockfish.stdin = 'quit';
//     await Future.delayed(const Duration(milliseconds: 200));
//   }

//   void startStockfishIfNecessary() {
//     if (_stockfish.state.value == StockfishState.ready ||
//         _stockfish.state.value == StockfishState.starting) {
//       return;
//     }
//     _doStartStockfish();
//   }
// }
