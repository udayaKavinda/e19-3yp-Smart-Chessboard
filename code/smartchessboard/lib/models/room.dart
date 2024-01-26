import 'package:smartchessboard/models/profile.dart';

class Room {
  bool gameModeOnline;
  List<Profile>? players;
  bool isWhite;
  String winner;
  String end;
  String roomId;

  Room({
    required this.gameModeOnline,
    this.players,
    this.isWhite = true,
    this.winner = "",
    this.end = "",
    this.roomId = "",
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json["_id"],
      gameModeOnline: json['gameModeOnline'],
      players: (json['players'] as List<dynamic>)
          .map((playerJson) => Profile.fromJson(playerJson))
          .toList(),
      isWhite: json['isWhite'],
    );
  }
}
