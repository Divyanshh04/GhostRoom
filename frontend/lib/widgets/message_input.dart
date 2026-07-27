import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFF141B2D),
          border: Border(
            top: BorderSide(
              color: Colors.white12,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: const TextStyle(
                    color: Colors.white54,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1A223A),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),

            const SizedBox(width: 10),

            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent,
              ),
              child: IconButton(
                onPressed: onSend,
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}