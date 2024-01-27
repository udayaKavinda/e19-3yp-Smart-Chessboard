import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:smartchessboard/widgets/the_chess_board.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});
  final String title = "Game Screen";
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late RoomDataProvider roomDataProvider;
  final SocketMethods _socketMethods = SocketMethods();
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
                  _socketMethods.gameDisconnect();
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

  @override
  void dispose() {
    roomDataProvider.removeListener(handleEndPopup);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    roomDataProvider = Provider.of<RoomDataProvider>(context, listen: false);
    roomDataProvider.addListener(handleEndPopup);
  }

  Future<void> handleEndPopup() async {
    if (roomDataProvider.roomData!.end != "") {
      bool quit = await showDialog<bool>(
            context: context,
            barrierDismissible: false, // Make the dialog non-dismissable
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(roomDataProvider.roomData!.end),
                content: Text('Are you sure you want to quit?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Perform any additional cleanup or actions before popping the screen
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Close the dialog and return true
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            },
          ) ??
          false;
      if (quit) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("3yp chess"),
          actions: [
            // IconButton(
            //   icon: Icon(
            //     _isConnected
            //         ? Icons.bluetooth_connected // Connected: Green icon
            //         : Icons.bluetooth_disabled, // Not connected: Grey icon
            //     color: _isConnected ? Colors.green : Colors.grey,
            //   ),
            //   onPressed: () {},
            // ),
          ],
        ),
        body: TheChessBoard(),
      ),
    );
  }
}
