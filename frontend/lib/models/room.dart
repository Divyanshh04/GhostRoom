import 'participant.dart';

class Room {
  final int roomCode;
  final String hostId;
  final int maxParticipants;
  final List<Participant> participants;
  final String status;

  Room({
    required this.roomCode,
    required this.hostId,
    required this.maxParticipants,
    required this.participants,
    required this.status,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      roomCode: json['roomCode'],
      hostId: json['hostId'],
      maxParticipants: json['maxParticipants'],
      participants: (json['participants'] as List)
          .map((p) => Participant.fromJson(p))
          .toList(),
      status: json['status'],
    );
  }
}