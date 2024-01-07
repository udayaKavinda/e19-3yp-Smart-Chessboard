import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/provider/room_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';
import 'package:smartchessboard/screens/game_screen.dart';
import 'package:smartchessboard/widgets/custom_button.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    _socketMethods.joinRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _socketMethods.disposeCrateJoinSockets();
    super.dispose();
  }

  void playGame(BuildContext context) {
    Navigator.pushNamed(context, GameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        //brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
          size: 20,
          color: Colors.black,),


        ),
      ),
      body: Container(
        height:650,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: <Widget>[
                  Text("Creat a Room",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 40,),
                  ],
                ),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage("assets/createroombackground.png"),
                        fit: BoxFit.fitHeight
                        ),

                      ),
                    ),
                    SizedBox(height: 80.0,),
                    Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        child:CustomButton(
                          onTap: () => _socketMethods.createOrJoinRoom(),
                          text: "Online Game", 
                            buttonColor: Color.fromARGB(255, 68, 68, 68),
                          ),
                      ),
                    SizedBox(height: 20.0,),
                    Container(
                        padding: EdgeInsets.only(top: 0, left: 3),
                        child:CustomButton(
                          onTap: () {
                            roomDataProvider.updateRoomData({
                              "isWhite": true,
                              "_id": "",
                              "gameModeOnline": false,
                              "players": []
                            });
                            playGame(context);
                            },
                          text: "Start",
                          buttonColor: Color(0xff0095FF),),
                    ),
                    ],
              ),
          ],
        ),
      ),
    );

  }
}


      // body: Container(
      //   width:double.infinity,
      //   margin: const EdgeInsets.symmetric(
      //     horizontal: 20,
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       const Text("Create Room"),
      //       CustomButton(
      //           onTap: () => _socketMethods.createOrJoinRoom(),
      //           text: "Online Game", 
      //           buttonColor: Color(0xff0095FF),
      //           ),
                
            // CustomButton(
            //     onTap: () {
            //       roomDataProvider.updateRoomData({
            //         "isWhite": true,
            //         "_id": "",
            //         "gameModeOnline": false,
            //         "players": []
            //       });
            //       playGame(context);
            //     },
            //     text: "Start", buttonColor: Color(0xff0095FF),),

      //     ],
      //   ),
      // ),