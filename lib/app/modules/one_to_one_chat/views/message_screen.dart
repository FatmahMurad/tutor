import 'package:flutter/material.dart';
import 'package:tutor/app/modules/chats/domain/models/user_model.dart';
import 'package:tutor/app/modules/one_to_one_chat/views/message_body_view.dart';

class OneToOneMessagingScreen extends StatelessWidget {
  final UserModel user;

  const OneToOneMessagingScreen({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.username.toString()),
      ),
      body: MessagingBodyView(selectedUser: user),
    );
  }
}
