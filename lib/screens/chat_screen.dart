import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_ai/providers/chat_messages_provider.dart';
import 'package:personal_ai/providers/chat_user_provider.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(chatUserProvider);
    final messages = ref.watch(chatMessagesProvider);

    return messages.when(
      data: (messages) => Chat(
            messages: messages,
            onSendPressed: (p0) {
              ref.read(chatMessagesProvider.notifier).sendMessage(p0.text);
            },
            user: user,
            avatarBuilder: (userId) => RandomAvatar(userId, width: 48),
            showUserAvatars: true,
            showUserNames: true,
      ), 
      error: (error, stack) => Center(
        child: Text('Error $error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
