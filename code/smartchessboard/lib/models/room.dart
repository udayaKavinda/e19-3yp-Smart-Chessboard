import 'package:smartchessboard/models/player.dart';

class Room {
  bool gameModeOnline;
  List<Player>? players;
  bool? isJoin;
  bool isWhite;
  String roomId;

  Room({
    required this.gameModeOnline,
    this.players,
    this.isJoin,
    this.isWhite = true,
    this.roomId = "",
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomId: json["_id"],
      gameModeOnline: json['gameModeOnline'],
      players: (json['players'] as List<dynamic>)
          .map((playerJson) => Player.fromJson(playerJson))
          .toList(),
      isJoin: json['isJoin'],
      isWhite: json['isWhite'],
    );
  }
}
