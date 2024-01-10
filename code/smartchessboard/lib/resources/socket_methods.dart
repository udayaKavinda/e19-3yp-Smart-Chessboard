import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/models/short_move.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_client.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createOrJoinRoom() {
    _socketClient.emit("createOrJoinRoom", {
      'nickname': "online",
    });
  }

  // void joinRoom(String nickname, String roomId) {
  //   if (nickname.isNotEmpty && roomId.isNotEmpty) {
  //     _socketClient.emit('joinRoom', {
  //       'nickname': nickname,
  //       'roomId': roomId,
  //     });
  //   }
  // }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      print("createRoomSuccess");
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      print("joinRoomSuccess");
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  void listenChessMoves(BuildContext context) {
    _socketClient.on('chessMove', (data) {
      Provider.of<MoveDataProvider>(context, listen: false)
          .updateMoveData(data);
    });
  }

  void sendChessMove(String from, String to, String roomId, String nextPlayer,
      String whoUpdate) {
    _socketClient.emit('chessMove', {
      'roomId': roomId,
      'from': from,
      'to': to,
      'nextPlayer': nextPlayer,
      'whoUpdate': whoUpdate,
    });
  }

  void disposeChessMoveSockets() {
    _socketClient.off('chessMove');
  }

  void disposeCrateJoinSockets() {
    _socketClient.off('createRoomSuccess');
    _socketClient.off('joinRoomSuccess');
  }
}
