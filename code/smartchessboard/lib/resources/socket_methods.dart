import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/models/short_move.dart';
import 'package:smartchessboard/provider/profile_data_provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_client.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  //game-screen
  void listenChessMoves(BuildContext context) {
    _socketClient.on('chessMove', (data) {
      Provider.of<MoveDataProvider>(context, listen: false)
          .updateMoveData(data);
    });
  }

  void sendChessMove(String from, String to, String? pieceToPromoteTo,
      String roomId, String nextPlayer, String whoUpdate) {
    _socketClient.emit('chessMove', {
      'roomId': roomId,
      'from': from,
      'to': to,
      'pieceToPromoteTo': pieceToPromoteTo,
      'nextPlayer': nextPlayer,
      'whoUpdate': whoUpdate,
    });
  }

  void gameDisconnect() {
    _socketClient.emit('gameDisconnect', {});
  }

  //community screen
  void disposeChessMoveSockets() {
    _socketClient.off('chessMove');
  }

  void listenCommunity(BuildContext context) {
    _socketClient.on('community', (data) {
      Provider.of<ProfileDataProvider>(context, listen: false)
          .updateOnlineProfilesData(data);
    });
  }

  void disposeCommunitySockets() {
    _socketClient.off('community');
  }

  void communityConnect() {
    _socketClient.emit('communityConnect', {});
  }

  void communityDisconnect() {
    _socketClient.emit('communityDisconnect', {});
  }

  //main-menu screen
  void initializeApp(String profileId) {
    _socketClient.emit('init', {"profileId": profileId});
  }

  void initializeAppListener(BuildContext context) {
    _socketClient.on('initDone', (data) {
      Provider.of<ProfileDataProvider>(context, listen: false)
          .updateMyProfile(data);
      _socketClient.off('initDone');
    });
  }

  //game-menu-screen
  void createOrJoinRoom() {
    _socketClient.emit("createOrJoinRoom", {
      'nickname': "online",
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void disposeCrateJoinSockets() {
    _socketClient.off('joinRoomSuccess');
  }

  void gameMenuDisconnect() {
    _socketClient.emit('gameMenuDisconnect', {});
  }
}
