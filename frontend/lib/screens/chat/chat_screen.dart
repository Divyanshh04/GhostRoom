import 'package:flutter/material.dart';

import '../../models/message.dart';
import '../../widgets/message_bubble.dart';
import '../../widgets/message_input.dart';
import '../../widgets/room_header.dart';
import '../../services/socket_service.dart';

class ChatScreen extends StatefulWidget {
    final String username;
    final String userId;
    final int roomCode;

    const ChatScreen({
        super.key,
        required this.username,
        required this.userId,
        required this.roomCode,
});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<Message> messages = [];
  final SocketService socketService = SocketService();
  int onlineUsers = 1;

@override
void initState() {
  super.initState();

  socketService.connect();

  socketService.joinRoom(
    roomCode: widget.roomCode,
    userId: widget.userId,
    username: widget.username,
  );

  socketService.onReceive((data) {
    setState(() {
      messages.add(
        Message(
          senderId: data["userId"],
          senderName: data["username"],
          message: data["message"],
          timestamp: DateTime.parse(data["timestamp"]),
          isMine: data["userId"] == widget.userId,
        ),
      );
    });
  });
socketService.onParticipantCount((data) {
  setState(() {
    onlineUsers = data["count"];
  });
});
}

@override
void dispose() {
  socketService.dispose();
  messageController.dispose();
  super.dispose();
}

  void sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) return;

    socketService.sendMessage(text);

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1020),

      body: SafeArea(
        child: Column(
          children: [
            RoomHeader(
              roomCode: widget.roomCode,
              onlineUsers: onlineUsers,
              connected: true,
            ),

            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        "No messages yet",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                          message: messages[index],
                        );
                      },
                    ),
            ),

            MessageInput(
              controller: messageController,
              onSend: sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}