import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lumios/providers/chat_messages_provider.dart';
import 'package:lumios/providers/chat_user_provider.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isLoadingProvider) 
      ? const Center(child: CircularProgressIndicator())
      : Chat(
        messages: ref.watch(chatMessagesProvider),
        onSendPressed: (p0) {
          ref.read(chatMessagesProvider.notifier).sendMessage(p0.text).catchError(onSendError);
        },
        user: ref.watch(chatUserProvider)!,
        avatarBuilder: (userId) => RandomAvatar(userId, width: 48),
        showUserAvatars: true,
        showUserNames: true,
        typingIndicatorOptions: TypingIndicatorOptions(typingUsers: ref.watch(typingUsersProvider)),
      );
  }

  void onSendError(Object error, StackTrace stackTrace) {
    print('Error sending message: $error');
    print(stackTrace);
    Fluttertoast.showToast(
      msg: "Cloud not send message. Please refresh the page.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
