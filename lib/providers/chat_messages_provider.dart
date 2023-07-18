import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:personal_ai/models/chat_message.dart';
import 'package:personal_ai/providers/ai_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'model_messages_provider.dart';
import 'chat_user_provider.dart';

part 'chat_messages_provider.g.dart';

@riverpod
List<User> typingUsers(TypingUsersRef ref) {
  final ai = ref.watch(aiUserProvider);
  final latestMessage = ref.watch(chatMessagesProvider.select((value) => value.firstOrNull));
  return latestMessage != null && ai != null && latestMessage.author.id != ai.id ? [ai] : [];
}

@riverpod
bool isLoading(IsLoadingRef ref) {
  return ref.watch(chatMessagesProvider.select((value) => value.isEmpty)) ||
    ref.watch(chatUserProvider.select((value) => value == null));
}

@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  List<Message> build() {
    print('Building chat messages view models.');
    final ai = ref.watch(aiUserProvider);
    final user = ref.watch(chatUserProvider);
    final modelMessages = ref.watch(modelMessagesProvider)
      .maybeWhen(orElse: () => <ChatMessage>[], data: (messages) => messages);
    if (ai == null || user == null) {
      return [];
    }
    final messages = modelMessages.map((m) => TextMessage(
        id: m.id.toString(), 
        text: m.message, 
        author: m.sender == ChatMessageSender.user 
        ? user 
        : ai,
        createdAt: m.timestamp.millisecondsSinceEpoch,
      ),
    ).toList();
    messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    return messages;
  }

  void sendMessage(String message) {
    final messageSender = ref.read(modelMessagesProvider.notifier);
    messageSender.sendMessage(ChatMessage(
        id: 0, 
        message: message, 
        timestamp: DateTime.now(), 
        sender: ChatMessageSender.user,
      ),
    );
  }
}
