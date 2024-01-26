class Player {
  String nickname;
  String socketID;
  String playerType;

  Player({
    required this.nickname,
    required this.socketID,
    required this.playerType,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      nickname: json['nickname'] ?? "udaya",
      socketID: json['socketID'],
      playerType: json['playerType'],
    );
  }
}
