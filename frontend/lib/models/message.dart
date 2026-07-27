class Message {
  final String senderId;
  final String senderName;
  final String message;
  final DateTime timestamp;
  final bool isMine;

  Message({
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isMine,
  });
}