import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/widgets/custom_button.dart';

class GameMenuScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const GameMenuScreen({super.key});

  @override
  State<GameMenuScreen> createState() => _GameMenuScreenState();
}

class _GameMenuScreenState extends State<GameMenuScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  // @override
  // void initState() {
  //   super.initState();
  //   _socketMethods.joinRoomSuccessListener(context);
  // }

  // @override
  // void dispose() {
  //   _socketMethods.disposeCrateJoinSockets();
  //   super.dispose();
  // }

  void playGame(BuildContext context) {
    Navigator.pushNamed(context, GameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        _socketMethods.gameMenuDisconnect();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          //brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              _socketMethods.gameMenuDisconnect();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          height: 650,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Play ",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/createroombackground.png"),
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    child: CustomButton(
                      onTap: () {
                        _socketMethods.createOrJoinRoom();
                      },
                      text: "Online Game",
                      buttonColor: Color.fromARGB(255, 68, 68, 68),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 3),
                    child: CustomButton(
                      onTap: () {
                        roomDataProvider.updateRoomData({
                          "isWhite": true,
                          "_id": "",
                          "gameModeOnline": false,
                          "players": []
                        });
                        playGame(context);
                      },
                      text: "Local Game",
                      buttonColor: Color(0xff0095FF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
