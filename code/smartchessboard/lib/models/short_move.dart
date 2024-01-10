class ShortMove {
  String from;
  String to;
  String nextPlayer;
  String? whoUpdate;

  ShortMove({
    required this.from,
    required this.to,
    this.nextPlayer = "white",
    this.whoUpdate,
  });

  factory ShortMove.fromJson(Map<String, dynamic> json) {
    return ShortMove(
        from: json['from'],
        to: json['to'],
        nextPlayer: json['nextPlayer'] ?? "white",
        whoUpdate: json['whoUpdate']);
  }
}
