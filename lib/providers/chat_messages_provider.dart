import 'dart:convert';
import 'dart:math';

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:personal_ai/models/chat_message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'model_messages_provider.dart';
import 'ai_provider.dart';
import 'chat_user_provider.dart';

part 'chat_messages_provider.g.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

@riverpod
class ChatMessages extends _$ChatMessages {
  @override
  Future<List<Message>> build() async {
    print('Building chat messages view models.');
    final ai = (await ref.watch(aiProviderProvider.future))!;
    final user = ref.watch(chatUserProvider);
    final modelMessages = await ref.watch(modelMessagesProvider.future);
    final aiUser = User(id: ai.name, firstName: ai.name);
    final messages = modelMessages.map((m) => TextMessage(
        id: m.id.toString(), 
        text: m.message, 
        author: m.sender == ChatMessageSender.user 
        ? user 
        : aiUser,
        createdAt: m.timestamp.millisecondsSinceEpoch,
      ),
    ).toList();
    messages.sort((a, b) => b.id.compareTo(a.id));

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
