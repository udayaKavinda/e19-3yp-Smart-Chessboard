import 'package:flutter/material.dart';
import 'package:smartchessboard/resources/socket_methods.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _gameIdController.dispose();
  }

    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2, // Adds shadow to the AppBar
        title: Container(
          width: double.infinity,
        ),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.home),
          onPressed: () {
            // Add your home button logic here
          },
        ),
        backgroundColor: Colors.lightBlue, // Setting the AppBar color to light blue
      ),
      body: Container(

        width: 350.0,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Join Room",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20), // Adds space between elements
            CustomTextField(hintText: "Name", controller: _nameController),
            SizedBox(height: 10), // Adds space between elements
            CustomTextField(hintText: "ID", controller: _gameIdController),
            SizedBox(height: 20), // Adds space between elements
            Container(
              padding: EdgeInsets.only(top: 3, left: 3),
              child: MaterialButton(
              minWidth: 250,
              height: 60,
              onPressed: () { 
                          
              },
              color: Color(0xff0095FF),
              elevation: 0,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              ),
             child: Text(
              "Join", style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,

              ),
            ),
            ),
            ),
          ],
        ),
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       margin: const EdgeInsets.symmetric(
  //         horizontal: 20,
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           const Text("join Room"),
  //           CustomTextField(hintText: "name", controller: _nameController),
  //           CustomTextField(hintText: "id", controller: _gameIdController),
  //           // CustomButton(
  //           // onTap: () => _socketMethods.joinRoom(
  //           //       _nameController.text,
  //           //       "658f318c6549389caf9719a9",
  //           //       // _gameIdController.text,
  //           //     ),
  //           // text: "join Room")
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.hintText, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:<Widget>[
              Text(
        hintText,
        textAlign:TextAlign.left,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color:Colors.black87
        ),

      ),
      SizedBox(
        height: 5,
      ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 189, 189, 189))
        )
        ),
      ),

      ],

    );
  }
}