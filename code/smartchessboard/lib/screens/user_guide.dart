import 'package:flutter/material.dart';

class UserGuide extends StatelessWidget {
  static String routeName = '/user-guide';
  const UserGuide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chess Game User Guide"),
        backgroundColor:
            const Color.fromARGB(255, 170, 143, 217), // Thematic color
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 16),
              UserGuideSection(
                title: 'Overview',
                content:
                    'Congratulations on choosing our chess app, where the timeless game of strategy meets cutting-edge technology. We\'ve taken chess to the next level by connecting it to a real chessboard through Bluetooth, providing you with a seamless and immersive experience. To make the most out of your chess journey, we\'ve created this user guide to help you navigate through the features and enjoy every move on and off the board.',
              ),
              UserGuideSection(
                title: 'Getting Started',
                content:
                    'Connecting your real chessboard via Bluetooth\nSetting up the app for the first time\nOverview of the app interface',
              ),
              UserGuideSection(
                title: 'Basic Gameplay',
                content:
                    'Making moves on the virtual board\nSyncing moves with the physical chessboard\nUnderstanding feedback and notifications',
              ),
              UserGuideSection(
                title: 'Bluetooth Connectivity',
                content:
                    'Troubleshooting connection issues\nReconnecting your chessboard\nTips for optimal Bluetooth performance',
              ),
              UserGuideSection(
                title: 'App Features',
                content:
                    'Exploring different game modes\nCustomizing the chessboard appearance\nAccessing game history and saved games',
              ),
              UserGuideSection(
                title: 'In-Game Assistance',
                content:
                    'Utilizing hints and analysis tools\nAdjusting difficulty levels\nResuming interrupted games',
              ),
              UserGuideSection(
                title: 'Flutter App Integration',
                content:
                    'Navigating through the app\'s various screens\nAccessing additional resources and settings\nProviding feedback and support',
              ),
              UserGuideSection(
                title: 'Chessboard Maintenance',
                content:
                    'Cleaning and caring for your real chessboard\nBattery management for Bluetooth connectivity\nStorage and travel tips',
              ),
              UserGuideSection(
                title: 'Frequently Asked Questions',
                content:
                    'Answers to common queries\nTroubleshooting tips\nContacting our support team',
              ),
              SizedBox(height: 16),
              Text(
                'We\'re thrilled to have you on board, ready to explore the world of chess with our innovative app. Whether you\'re a seasoned player or just starting, this guide is designed to enhance your experience and make every move on the chessboard a memorable one. Happy playing!\n\nFor additional assistance or feedback, visit our website or contact our support team.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
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
        style: const TextStyle(
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
