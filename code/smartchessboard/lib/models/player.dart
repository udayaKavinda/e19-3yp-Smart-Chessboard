class Player {
  String nickname;
  String socketID;
  int points;
  String playerType;

  Player({
    required this.nickname,
    required this.socketID,
    this.points = 0,
    required this.playerType,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      nickname: json['nickname'] ?? "udaya",
      socketID: json['socketID'],
      points: json['points'] ?? 0,
      playerType: json['playerType'],
    );
  }
}
