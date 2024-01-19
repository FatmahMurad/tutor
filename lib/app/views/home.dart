import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutor/app/config/extensions/context_extensions.dart';
import 'package:tutor/app/modules/chats/domain/models/user_model.dart';
import 'package:tutor/app/modules/chats/domain/providers/providers.dart';
import 'package:tutor/app/modules/one_to_one_chat/widgets/chat_user_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUsers = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.translate.users)),
      body: chatUsers.when(data: (List<UserModel> data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final user = data[index];
            return ChatUserCard(user: user);
          },
        );
      }, error: (Object error, StackTrace stackTrace) {
        return Center(child: Text(context.translate.errorFetchingUsers));
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
