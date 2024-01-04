import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/widgets/custom_button.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    _socketMethods.joinRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _socketMethods.disposeCrateJoinSockets();
    super.dispose();
  }

  void playGame(BuildContext context) {
    Navigator.pushNamed(context, GameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Create Room"),
            CustomButton(
                onTap: () => _socketMethods.createOrJoinRoom(),
                text: "Online Game"),
            CustomButton(
                onTap: () {
                  roomDataProvider.updateRoomData({
                    "isWhite": true,
                    "_id": "",
                    "gameModeOnline": false,
                    "players": []
                  });
                  playGame(context);
                },
                text: "play"),
          ],
        ),
      ),
    );
  }
}
