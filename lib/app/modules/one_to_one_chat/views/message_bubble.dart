import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor/app/config/extensions/context_extensions.dart';
import 'package:tutor/app/config/theme/my_colors.dart';
import 'package:tutor/app/modules/one_to_one_chat/domain/models/message.dart';
import 'package:tutor/app/modules/one_to_one_chat/views/date_and_time.dart';

class MessageBubble extends StatelessWidget with CustomDateTimeFormatter {
  final Message message;

  const MessageBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            message.senderId == FirebaseAuth.instance.currentUser!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                message.senderId == FirebaseAuth.instance.currentUser!.uid
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: message.senderId ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? Colors.blue[100]
                        : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: message.senderId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? const Radius.circular(15)
                          : const Radius.circular(0),
                      bottomRight: message.senderId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? const Radius.circular(0)
                          : const Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    message.message,
                    style: context.textTheme.bodyMedium?.copyWith(
                        color: message.senderId ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? Colors.black
                            : Colors.black87),
                  ),
                ),
              ),
            ],
          ),
          Text(
            formatChatDateTime(message.timestamp, context),
            style: context.textTheme.bodySmall
                ?.copyWith(color: MyColors.greyscale_500),
          ),
        ],
      ),
    );
  }
}
