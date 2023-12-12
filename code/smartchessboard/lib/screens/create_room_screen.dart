import 'package:flutter/material.dart';
import 'package:smartchessboard/widgets/custom_button.dart';
import 'package:smartchessboard/widgets/custom_textfield.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
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
            const Text("Create Room"),
            CustomTextField(hintText: "create", controller: _textController),
            CustomButton(onTap: () {}, text: "Create Room")
          ],
        ),
      ),
    );
  }
}
