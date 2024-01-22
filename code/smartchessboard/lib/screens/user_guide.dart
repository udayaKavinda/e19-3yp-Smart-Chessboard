import 'package:flutter/material.dart';

class UserGuide extends StatelessWidget {
  const UserGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Guide"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the Chess Game User Guide!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '1. Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Learn how to make moves, customize settings, and enjoy the game.',
            ),
            SizedBox(height: 16),
            Text(
              '2. Making Moves',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'To make a move, tap on a chess piece and then tap on the destination square.',
            ),
            SizedBox(height: 16),
            Text(
              '3. Customizing Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Explore the settings to customize your chessboard appearance and game preferences.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Enjoy the Game!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Connect with friends, play chess, and have fun!',
            ),
          ],
        ),
      ),
    );
  }
}
