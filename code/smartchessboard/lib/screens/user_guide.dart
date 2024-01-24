import 'package:flutter/material.dart';

class UserGuide extends StatelessWidget {
  const UserGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Guide"),
        backgroundColor: const Color.fromARGB(255, 170, 143, 217), // Thematic color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to the Chess Game User Guide! ♟️',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Thematic color
                ),
              ),
              const SizedBox(height: 16),
              UserGuideSection(
                title: 'Overview',
                content: 'This is a new revolution in world chess game',
              ),
              UserGuideSection(
                title: 'Making Moves',
                content: 'Tap on a chess piece and then tap on the destination square.',
              ),
              UserGuideSection(
                title: 'Customizing Settings',
                content: 'Personalize your chessboard appearance and game preferences.',
              ),
              UserGuideSection(
                title: 'Enjoy the Game!',
                content: 'Connect with friends, play chess, and have fun!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserGuideSection extends StatelessWidget {
  final String title;
  final String content;

  const UserGuideSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
      ],
    );
  }
}
