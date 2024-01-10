import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/screens/create_room_screen.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/screens/join_room_screen.dart';
import 'package:smartchessboard/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  void playGame(BuildContext context) {
    Navigator.pushNamed(context, GameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            onTap: () {
              roomDataProvider.updateRoomData({
                "isWhite": true,
                "_id": "",
                "gameModeOnline": false,
                "players": []
              });
              createRoom(context);
            },
            text: "Create a new Room",
            buttonColor: Color(0xff0095FF),
          ),
          CustomButton(
            onTap: () => joinRoom(context),
            text: "Join a Room",
            buttonColor: Color(0xff0095FF),
          ),
          CustomButton(
            onTap: () => playGame(context),
            text: "play",
            buttonColor: Color(0xff0095FF),
          ),
        ],
      ),
    );
  }
}
