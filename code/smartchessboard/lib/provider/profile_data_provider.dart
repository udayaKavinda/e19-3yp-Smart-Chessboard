import 'package:flutter/material.dart';
import 'package:smartchessboard/models/profile.dart';

class ProfileDataProvider extends ChangeNotifier {
  List<Profile> _onlineProfilesData =
      []; // Use List<Profile> instead of Profile

  late Profile _myProfile;
  Profile get myProfile => _myProfile;

  List<Profile>? get onlineProfilesData => _onlineProfilesData;

  void updateOnlineProfilesData(List<dynamic> dataArray) {
    List<Profile> profiles = [];

    for (var data in dataArray) {
      profiles.add(Profile.fromJson(data));
    }
    _onlineProfilesData = profiles; // Assign the entire list to _profileData
    notifyListeners();
  }

  void updateMyProfile(Map<String, dynamic> data) {
    _myProfile = Profile.fromJson(data);
  }
}
