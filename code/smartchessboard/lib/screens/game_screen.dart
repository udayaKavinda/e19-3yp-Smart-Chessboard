import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/bluetooth_helper.dart';
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
  late BluetoothHelper _bluetoothHelper;
  late MoveDataProvider moveDataProvider;
  late RoomDataProvider roomDataProvider;
  ChessBoardController controller = ChessBoardController();
  final SocketMethods _socketMethods = SocketMethods();
  late bool isWhite;
  late String roomId;
  late String nextPlayer = "white";
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _bluetoothHelper = BluetoothHelper(context);
    moveDataProvider = Provider.of<MoveDataProvider>(context, listen: false);
    moveDataProvider.addListener(handleChessMove);
    _socketMethods.listenChessMoves(context);
    _bluetoothHelper.initBluetooth();
    _bluetoothHelper.addConnectionListener((bool isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });

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
    _bluetoothHelper.removeConnectionListener(_onConnectionChanged);
    _bluetoothHelper.dispose();
    super.dispose();
  }

  void _onConnectionChanged(bool isConnected) {
    setState(() {
      _isConnected = isConnected;
    });
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

  void handleChessMove() {
    final MoveDataProvider moveDataProvider =
        Provider.of<MoveDataProvider>(context, listen: false);

    // Check if moveData is not null before processing
    if (moveDataProvider.shortMoveData != null) {
      String from = moveDataProvider.shortMoveData!.from;
      String to = moveDataProvider.shortMoveData!.to;
      nextPlayer = moveDataProvider.shortMoveData!.nextPlayer;
      String? whoUpdate = moveDataProvider.shortMoveData!.whoUpdate;

      setState(() {
        nextPlayer;
      });
      if (whoUpdate != "bluetooth") {
        _bluetoothHelper
            .sendMessage({"from": from, "to": to, "nextPlayer": nextPlayer});
      }
      if (roomDataProvider.roomData!.gameModeOnline && whoUpdate != "socket") {
        _socketMethods.sendChessMove(from, to, roomId, nextPlayer, "socket");
      }
      if (whoUpdate != "local") {
        controller.makeMove(from: from, to: to);
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("3yp chess"),
          actions: [
            IconButton(
              icon: Icon(
                _isConnected
                    ? Icons.bluetooth_connected // Connected: Green icon
                    : Icons.bluetooth_disabled, // Not connected: Grey icon
                color: _isConnected ? Colors.green : Colors.grey,
              ),
              onPressed: () {},
            ),
          ],
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
            moveDataProvider.updateMoveData({
              "from": controller.game.history.last.move.fromAlgebraic,
              "to": controller.game.history.last.move.toAlgebraic,
              "nextPlayer": "white" == nextPlayer ? "black" : "white",
              "whoUpdate": "local",
            });
          },
        ),
      ),
    );
  }
}
