import 'package:flutter/material.dart';
import 'package:smartchessboard/screens/create_room_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
              onTap: () => createRoom(context), text: "Create a new Room"),
          CustomButton(onTap: () => joinRoom(context), text: "Join a Room"),
        ],
      ),
    );
  }
}
