import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, this.isMe, {Key? key}) : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.white : Colors.white,
            borderRadius: BorderRadius.only(
                topRight: const Radius.circular(12),
                topLeft: const Radius.circular(12),
                bottomRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(12),
                bottomLeft: isMe
                    ? const Radius.circular(12)
                    : const Radius.circular(0)),
          ),
          width: 250,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            message,
            style: TextStyle(
                color: isMe ? Colors.black : Colors.black,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
