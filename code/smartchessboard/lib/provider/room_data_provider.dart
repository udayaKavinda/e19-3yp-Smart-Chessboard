import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartchessboard/models/room.dart';
import 'package:smartchessboard/provider/profile_data_provider.dart';

class RoomDataProvider extends ChangeNotifier {
  Room? _roomData; // Assuming Room is a class representing your room structure

  Room? get roomData => _roomData;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = Room.fromJson(data);
    if (_roomData!.gameModeOnline) {
      if (_roomData!.players!.first.profileId !=
          Platform.operatingSystemVersion) {
        _roomData!.isWhite = true;
      } else {
        _roomData!.isWhite = false;
      }
    }
    notifyListeners();
  }

  void updateWinnerData(String data) {
    if (roomData!.end == "") {
      _roomData!.end = data;
      notifyListeners();
    }
  }
}
