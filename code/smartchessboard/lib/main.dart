import 'package:flutter/material.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart'; // Import your MoveDataProvider class
import 'package:smartchessboard/screens/create_room_screen.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/screens/join_room_screen.dart';
import 'package:smartchessboard/screens/main_menu_screen.dart';
import 'package:smartchessboard/screens/login_screen.dart';
import 'package:smartchessboard/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/screens/welcome_screen.dart';

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
        ChangeNotifierProvider(create: (context) => RoomDataProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                MoveDataProvider()), // Add your MoveDataProvider here
      ],
      child: MaterialApp(
        title: "chess",
        debugShowCheckedModeBanner: false,
        initialRoute: WelcomeScreen.routeName,
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
          SignupPage.routeName: (context) => const SignupPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        },
      ),
    );
  }
}
