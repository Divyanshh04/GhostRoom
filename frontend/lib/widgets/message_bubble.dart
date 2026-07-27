import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: message.isMine
              ? Colors.cyanAccent.withOpacity(0.15)
              : const Color(0xFF1A223A),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(
              message.isMine ? 18 : 4,
            ),
            bottomRight: Radius.circular(
              message.isMine ? 4 : 18,
            ),
          ),
          border: Border.all(
            color: message.isMine
                ? Colors.cyanAccent
                : Colors.deepPurpleAccent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.senderName,
              style: TextStyle(
                color: message.isMine
                    ? Colors.cyanAccent
                    : Colors.purpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              message.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}