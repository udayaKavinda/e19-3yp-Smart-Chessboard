import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
// import 'package:smartchessboard/chessGame/chess_engine.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/bluetooth_helper.dart';
import 'package:smartchessboard/resources/socket_methods.dart';

class TheChessBoard extends StatefulWidget {
  const TheChessBoard({super.key});

  @override
  State<TheChessBoard> createState() => _TheChessBoardState();
}

class _TheChessBoardState extends State<TheChessBoard> with WindowListener {
  String myfen = "rnbqkbnr/pppp1ppp/8/4p3/3P4/8/PPP2PPP/R1BQKBNR b KQkq - 0 5";
  final SocketMethods _socketMethods = SocketMethods();
  late BluetoothHelper _bluetoothHelper;
  ChessBoardController controller = ChessBoardController();
  // late ChessEngine _chessEngine;
  late MoveDataProvider moveDataProvider;
  late RoomDataProvider roomDataProvider;
  late bool isWhite;
  late String roomId;
  late String nextPlayer = "white";

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _overrideDefaultCloseHandler();
    _bluetoothHelper = BluetoothHelper();
    _bluetoothHelper.initBluetooth();
    _socketMethods.listenChessMoves(context);
    // _chessEngine = ChessEngine();
    controller.addListener(() {
      if (controller.isCheckMate()) {
        roomDataProvider.updateWinnerData("CheckMate");
      } else if (controller.isDraw()) {
        roomDataProvider.updateWinnerData("Draw");
      } else if (controller.isStaleMate()) {
        roomDataProvider.updateWinnerData("StaleMate");
      } else if (controller.isThreefoldRepetition()) {
        roomDataProvider.updateWinnerData("ThreefoldRepetition");
      } else {}
    });
    moveDataProvider = Provider.of<MoveDataProvider>(context, listen: false);
    moveDataProvider.addListener(handleChessMove);
  }

  @override
  void dispose() {
    _socketMethods.disposeChessMoveSockets();
    _bluetoothHelper.dispose();
    // _chessEngine.stopStockfish();
    controller.resetBoard();
    controller.dispose();
    moveDataProvider.removeListener(handleChessMove);
    super.dispose();
  }

  Future<void> _overrideDefaultCloseHandler() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    // _chessEngine.stopStockfish();
    await Future.delayed(const Duration(milliseconds: 200));
    await windowManager.destroy();
  }

  Future<void> handleChessMove() async {
    final MoveDataProvider moveDataProvider =
        Provider.of<MoveDataProvider>(context, listen: false);

    // Check if moveData is not null before processing
    if (moveDataProvider.shortMoveData != null) {
      String from = moveDataProvider.shortMoveData!.from;
      String to = moveDataProvider.shortMoveData!.to;
      nextPlayer = moveDataProvider.shortMoveData!.nextPlayer;
      String? whoUpdate = moveDataProvider.shortMoveData!.whoUpdate;
      String? pieceToPromoteTo =
          moveDataProvider.shortMoveData!.pieceToPromoteTo;

      setState(() {
        nextPlayer;
      });
      if (whoUpdate != "bluetooth") {
        _bluetoothHelper
            .sendMessage({"from": from, "to": to, "nextPlayer": nextPlayer});
      }
      if (roomDataProvider.roomData!.gameModeOnline && whoUpdate != "socket") {
        _socketMethods.sendChessMove(
            from, to, pieceToPromoteTo, roomId, nextPlayer, "socket");
      }
      if (whoUpdate != "local") {
        if (pieceToPromoteTo == null) {
          controller.makeMove(from: from, to: to);
        } else {
          controller.makeMoveWithPromotion(
              from: from, to: to, pieceToPromoteTo: pieceToPromoteTo);
        }
      }

      if ((isWhite && nextPlayer == "white") ||
          (!isWhite && nextPlayer == "black")) {
        //my turn
      } else {
        //opponent turn
        if (roomDataProvider.roomData!.gameModeOnline) {
          //online
        } else {
          //local
          // _chessEngine.startStockfishIfNecessary();
          // _chessEngine.computeNextMove(controller.game.fen);
          // await Future.delayed(
          //     Duration(milliseconds: 500 + _chessEngine.timeInMs));
          // if (_chessEngine.bestMove.substring(0, 2).length == 5) {
          //   controller.makeMoveWithPromotion(
          //       from: _chessEngine.bestMove.substring(0, 2),
          //       to: _chessEngine.bestMove.substring(2, 4),
          //       pieceToPromoteTo: _chessEngine.bestMove.substring(4));
          // } else {
          //   controller.makeMove(
          //       from: _chessEngine.bestMove.substring(0, 2),
          //       to: _chessEngine.bestMove.substring(2));
          // }
          // moveDataProvider.updateMoveData({
          //   "from": controller.game.history.last.move.fromAlgebraic,
          //   "to": controller.game.history.last.move.toAlgebraic,
          //   "pieceToPromoteTo":
          //       controller.game.history.last.move.promotion?.name,
          //   "nextPlayer": "white" == nextPlayer ? "black" : "white",
          //   "whoUpdate": "local",
          // });

          List<Move> legalMoves = controller.getPossibleMoves();
          if (legalMoves.isNotEmpty) {
            final int randomIndex = Random().nextInt(legalMoves.length);
            controller.makeMove(
                from: legalMoves[randomIndex].fromAlgebraic,
                to: legalMoves[randomIndex].toAlgebraic);
          }
          moveDataProvider.updateMoveData({
            "from": controller.game.history.last.move.fromAlgebraic,
            "to": controller.game.history.last.move.toAlgebraic,
            "nextPlayer": "white" == nextPlayer ? "black" : "white",
            "whoUpdate": "local",
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    roomDataProvider = Provider.of<RoomDataProvider>(context);
    isWhite = roomDataProvider.roomData!.isWhite;
    roomId = roomDataProvider.roomData!.roomId;
    return ChessBoard(
      controller: controller,
      arrows: [
        BoardArrow(
          from: controller.game.history.isEmpty
              ? 'a1'
              : controller.game.history.last.move.fromAlgebraic,
          to: controller.game.history.isEmpty
              ? 'a1'
              : controller.game.history.last.move.toAlgebraic,
          color: Colors.green.withOpacity(0.5),
        ),
      ],
      boardColor: BoardColor.green,
      boardOrientation: isWhite ? PlayerColor.white : PlayerColor.black,
      enableUserMoves: (isWhite && nextPlayer == "white") ||
          (!isWhite && nextPlayer == "black"),
      onMove: () {
        moveDataProvider.updateMoveData({
          "from": controller.game.history.last.move.fromAlgebraic,
          "to": controller.game.history.last.move.toAlgebraic,
          "pieceToPromoteTo": controller.game.history.last.move.promotion?.name,
          "nextPlayer": "white" == nextPlayer ? "black" : "white",
          "whoUpdate": "local",
        });
      },
    );
  }
}
