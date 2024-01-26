class Profile {
  String nickname;
  String socketId;
  String profileId;

  Profile({
    required this.nickname,
    required this.socketId,
    required this.profileId,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        nickname: json['nickname'],
        socketId: json['socketId'],
        profileId: json['profileId']);
  }
}
