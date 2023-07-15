import 'dart:convert';
import 'dart:math';

import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:personal_ai/providers/ai_provider.dart';
import 'package:personal_ai/providers/chat_user_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_messages_provider.g.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

@riverpod
Future<List<Message>> chatMessages(ChatMessagesRef ref) async {
  final ai = (await ref.watch(aiProviderProvider.future))!;
  final user = ref.watch(chatUserProvider);
  
  return [
    TextMessage(
      id: randomString(),
      text: 'Hi, ${ai.name}!',
      author: user,
    ),    
    TextMessage(
      id: randomString(),
      text: 'Hi, ${user.firstName}',
      author: User(id: ai.name, firstName: ai.name),
    )
  ];
}
