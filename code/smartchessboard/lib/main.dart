import 'package:flutter/material.dart';
import 'package:smartchessboard/provider/profile_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart'; // Import your MoveDataProvider class
import 'package:smartchessboard/screens/game_menu_screen.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/screens/join_community.dart';
import 'package:smartchessboard/screens/play_friends_screen.dart';
import 'package:smartchessboard/screens/home.dart';
import 'package:smartchessboard/screens/login.dart';
import 'package:smartchessboard/screens/signup.dart';
import 'package:smartchessboard/screens/main_menu.dart';
import 'package:provider/provider.dart';

void main() {
  //runApp(const MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileDataProvider()),
        ChangeNotifierProvider(create: (context) => RoomDataProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                MoveDataProvider()), // Add your MoveDataProvider here
      ],
      child: MaterialApp(
        title: "chess",
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (contex) => HomePage(),
          LoginPage.routeName: (context) => LoginPage(),
          SignupPage.routeName: (context) => SignupPage(),
          MainMenu.routeName: (context) => MainMenu(),
          PlayFriendsScreen.routeName: (context) => const PlayFriendsScreen(),
          GameMenuScreen.routeName: (context) => const GameMenuScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
          JoinCommunityScreen.routeName: (context) =>
              const JoinCommunityScreen(),
        },
      ),
    );
  }
}
