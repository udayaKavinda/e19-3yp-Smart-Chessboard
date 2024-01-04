class ShortMove {
  String from;
  String to;
  String nextPlayer;

  ShortMove({
    required this.from,
    required this.to,
    this.nextPlayer = "white",
  });

  factory ShortMove.fromJson(Map<String, dynamic> json) {
    return ShortMove(
      from: json['from'],
      to: json['to'],
      nextPlayer: json['nextPlayer'] ?? "white",
    );
  }
}
