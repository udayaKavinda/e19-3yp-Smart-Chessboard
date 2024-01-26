import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartchessboard/models/profile.dart';
import 'package:smartchessboard/provider/profile_data_provider.dart';
import 'package:smartchessboard/resources/socket_methods.dart';

class JoinCommunityScreen extends StatefulWidget {
  static String routeName = '/join-community';
  const JoinCommunityScreen({Key? key}) : super(key: key);

  @override
  State<JoinCommunityScreen> createState() => _JoinCommunityScreenState();
}

class _JoinCommunityScreenState extends State<JoinCommunityScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _socketMethods.communityConnect();
    _socketMethods.listenCommunity(context);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _socketMethods.disposeCommunitySockets();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileDataProvider communityDataProvider =
        Provider.of<ProfileDataProvider>(context);
    int length = communityDataProvider.onlineProfilesData!.length;
    List<Profile> onlinePlayers = communityDataProvider.onlineProfilesData!;
    PageController _pageController = PageController(initialPage: 0);
    return WillPopScope(
      onWillPop: () async {
        _socketMethods.communityDisconnect();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your App"),
        ),
        body: Column(
          children: [
            // Single scrollable button to switch between Online Players and Leaderboard
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Text("Online Players"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Text("Leaderboard"),
                  ),
                ],
              ),
            ),
            // PageView to switch between Online Players and Leaderboard
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  // Online Players
                  ListView.builder(
                    itemCount: communityDataProvider.onlineProfilesData!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Show a dialog box asking if the user wants to play
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    "Play with ${onlinePlayers[index].nickname}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Handle the user's choice (e.g., initiate a game)
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      // Add your logic to initiate a game here
                                      print(
                                          "Initiate a game with ${onlinePlayers[index].nickname}");
                                    },
                                    child: Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(onlinePlayers[index].nickname),
                        ),
                      );
                    },
                  ),
                  // Leaderboard
                  ListView(
                    children: [
                      ListTile(title: Text("Player A - Score: 100")),
                      ListTile(title: Text("Player B - Score: 90")),
                      // Add more leaderboard items
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
