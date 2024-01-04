import 'package:flutter/material.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:smartchessboard/widgets/custom_button.dart';
import 'package:smartchessboard/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("join Room"),
            CustomTextField(hintText: "name", controller: _nameController),
            CustomTextField(hintText: "id", controller: _gameIdController),
            // CustomButton(
            // onTap: () => _socketMethods.joinRoom(
            //       _nameController.text,
            //       "658f318c6549389caf9719a9",
            //       // _gameIdController.text,
            //     ),
            // text: "join Room")
          ],
        ),
      ),
    );
  }
}
