import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'amplifyconfiguration.dart';

import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/provider/move_data_provider.dart';
import 'package:smartchessboard/screens/create_room_screen.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/screens/join_room_screen.dart';
import 'package:smartchessboard/screens/main_menu_screen.dart';
import 'package:smartchessboard/screens/home.dart';
import 'package:smartchessboard/screens/login.dart';
import 'package:smartchessboard/screens/signup.dart';
import 'package:smartchessboard/screens/mainmenu.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => RoomDataProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                MoveDataProvider()), // Add your MoveDataProvider here
    ],
    child:Authenticator(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName:(contex)=>HomePage(),
          MainMenu.routeName:(context)=>MainMenu(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        }
      ),
    ));

  }
}

