import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});
  final String title = "Game Screen";

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late MoveDataProvider moveDataProvider;
  ChessBoardController controller = ChessBoardController();
  final SocketMethods _socketMethods = SocketMethods();
  late bool isWhite;
  late String roomId;
  late String nextPlayer = "white";

  @override
  void initState() {
    super.initState();
    moveDataProvider = Provider.of<MoveDataProvider>(context, listen: false);
    moveDataProvider.addListener(handleChessMove);
    _socketMethods.listenChessMoves(context);

    controller.addListener(() {
      if (controller.isCheckMate()) {
        print('Checkmate!');
      } else if (controller.isDraw()) {
        print('Draw!');
      } else if (controller.isStaleMate()) {
        print('Stalemate!');
      } else if (controller.isThreefoldRepetition()) {
        print('Threefold Repetition!');
      } else {}
    });
  }

  @override
  void dispose() {
    _socketMethods.disposeChessMoveSockets();
    moveDataProvider.removeListener(handleChessMove);
    controller.resetBoard();
    controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the game?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  // Perform any additional cleanup or actions before popping the screen
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void opponent(RoomDataProvider roomDataProvider) {
    if (roomDataProvider.roomData!.gameModeOnline) {
      _socketMethods.sendChessMove(
          controller.game.history.last.move.fromAlgebraic,
          controller.game.history.last.move.toAlgebraic,
          roomId,
          nextPlayer);
    } else {
      List<Move> legalMoves = controller.getPossibleMoves();
      if (legalMoves.isNotEmpty) {
        final int randomIndex = Random().nextInt(legalMoves.length);
        controller.makeMove(
            from: legalMoves[randomIndex].fromAlgebraic,
            to: legalMoves[randomIndex].toAlgebraic);
      }
      setState(() {
        nextPlayer = "white" == nextPlayer ? "black" : "white";
      });
    }
  }

  void handleChessMove() {
    final MoveDataProvider moveDataProvider =
        Provider.of<MoveDataProvider>(context, listen: false);

    // Check if moveData is not null before processing
    if (moveDataProvider.shortMoveData != null) {
      // Extract necessary information (from, to, nextPlayer) and update the chess board
      String from = moveDataProvider.shortMoveData!.from;
      String to = moveDataProvider.shortMoveData!.to;
      nextPlayer = moveDataProvider.shortMoveData!.nextPlayer;

      // Update the chess board with the received move
      controller.makeMove(from: from, to: to);

      // Update the player turn
      setState(() {
        nextPlayer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    isWhite = roomDataProvider.roomData!.isWhite;
    roomId = roomDataProvider.roomData!.roomId;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("3yp chess"),
        ),
        body: ChessBoard(
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
            setState(() {
              nextPlayer = "white" == nextPlayer ? "black" : "white";
            });
            opponent(roomDataProvider);
          },
        ),
      ),
    );
  }
}
