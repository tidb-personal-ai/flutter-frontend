import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              Fluttertoast.showToast(
                msg: p0.text,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
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
