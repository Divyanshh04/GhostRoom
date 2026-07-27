import 'package:flutter/material.dart';

class RoomHeader extends StatelessWidget {
  final int roomCode;
  final int onlineUsers;
  final bool connected;

  const RoomHeader({
    super.key,
    required this.roomCode,
    required this.onlineUsers,
    required this.connected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        color: const Color(0xFF141B2D),
        border: Border(
          bottom: BorderSide(
            color: Colors.cyanAccent.withOpacity(0.25),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room #$roomCode",
            style: const TextStyle(
              color: Colors.cyanAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: connected
                    ? Colors.greenAccent
                    : Colors.redAccent,
              ),

              const SizedBox(width: 8),

              Text(
                connected ? "Connected" : "Disconnected",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.people,
                color: Colors.white70,
              ),

              const SizedBox(width: 6),

              Text(
                "$onlineUsers Online",
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}