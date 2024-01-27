import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/profile_data_provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:smartchessboard/screens/game_menu_screen.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/screens/join_community.dart';
import 'package:smartchessboard/screens/play_friends_screen.dart';
import 'package:smartchessboard/screens/user_guide.dart';
// import 'package:amplify_authenticator/amplify_authenticator.dart';

class MainMenu extends StatelessWidget {
  final SocketMethods _socketMethods = SocketMethods();
  static String routeName = '/main-menu';

  void ReadUserGuide(BuildContext context) {
    Navigator.pushNamed(context, UserGuide.routeName);
  }

  void JoinCommunity(BuildContext context) {
    Navigator.pushNamed(context, JoinCommunityScreen.routeName);
  }

  void playGame(BuildContext context) {
    Navigator.pushNamed(context, GameMenuScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    _socketMethods.initializeApp(Platform.operatingSystemVersion);
    _socketMethods.initializeAppListener(context);
    // return AuthenticatedView(
    return Scaffold(
      body: SafeArea(
        child: Container(
          // we will give media query height
          // double.infinity make it big as my parent allows
          // while MediaQuery make it big as per the screen

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Hi!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your Move, Anywhere in the World\nSmartChess Board, Infinite Play",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/mainmenubackground.png"))),
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 250,
                    height: 60,
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                      playGame(context);
                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 50),
                  MaterialButton(
                    minWidth: 250,
                    height: 60,
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      JoinCommunity(context);
                    },
                    color: Color.fromARGB(255, 68, 68, 68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      // side: BorderSide(
                      //   color: Colors.black
                      // ),
                    ),
                    child: Text(
                      "Join Community",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                  ),
                  // creating the signup button
                  SizedBox(height: 20),
                  MaterialButton(
                    minWidth: 250,
                    height: 60,
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                      ReadUserGuide(context);
                    },
                    color: Color.fromARGB(255, 68, 68, 68),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      // side: BorderSide(
                      //   color: Colors.black
                      // ),
                    ),
                    child: Text(
                      "User Guide",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
