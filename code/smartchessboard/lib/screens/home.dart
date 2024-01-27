import 'package:flutter/material.dart';
import 'package:smartchessboard/screens/login.dart';
// import 'package:smartchessboard/screens/mainmenu.dart';
import 'package:smartchessboard/screens/signup.dart';
import 'package:smartchessboard/screens/user_guide.dart';

class HomePage extends StatelessWidget {
  static String routeName = '/home';

  void LogIn(BuildContext context) {
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  void SingUp(BuildContext context) {
    Navigator.pushNamed(context, SignupPage.routeName);
  }

  void GoMainMenu(BuildContext context) {
    //Navigator.pushNamed(context, SignupPage.routeName);
    // Navigator.pushNamed(context, MainMenu.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
                    "Welcome",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Experience live chess moves on a real board\nConnect, play, and enjoy the game",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/welcome.png"))),
              ),
              Column(
                children: <Widget>[
                  // the login button
                  // MaterialButton(
                  //   minWidth:250,
                  //   height: 60,
                  //   onPressed: () {
                  //     //LogIn(context);
                  //     GoMainMenu(context);

                  //   },
                  //   // defining the shape
                  //   shape: RoundedRectangleBorder(
                  //     side: BorderSide(
                  //       color: Colors.black
                  //     ),
                  //     borderRadius: BorderRadius.circular(50)
                  //   ),
                  //   child: Text(
                  //     "Login",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       fontSize: 15
                  //     ),
                  //   ),
                  // ),
                  // creating the signup button
                  SizedBox(height: 10),
                  MaterialButton(
                    minWidth: 250,
                    height: 60,
                    onPressed: () {
                      //SingUp(context);
                      GoMainMenu(context);
                    },
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    ),
                  ),

                  Container(height: 10),
                  // Add User Guide button
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.of(context)
                  //         .push(MaterialPageRoute(builder: (_) {
                  //       return UserGuide();
                  //     }));
                  //   },
                  //   child: Text(
                  //     "User Guide",
                  //     style: TextStyle(
                  //       color: Colors.blue,
                  //       fontWeight: FontWeight.w300,
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
