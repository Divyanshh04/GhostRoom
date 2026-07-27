class Participant {
  final String userId;
  final String username;

  Participant({
    required this.userId,
    required this.username,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['userId'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
    };
  }
}