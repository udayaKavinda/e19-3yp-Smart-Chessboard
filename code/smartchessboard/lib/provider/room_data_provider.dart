import 'package:flutter/material.dart';
import 'package:smartchessboard/models/room.dart';

class RoomDataProvider extends ChangeNotifier {
  Room? _roomData; // Assuming Room is a class representing your room structure

  Room? get roomData => _roomData;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = Room.fromJson(data);
    notifyListeners();
  }
}
