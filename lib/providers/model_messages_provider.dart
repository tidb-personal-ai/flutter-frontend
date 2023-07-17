
import 'dart:convert';
import 'dart:math';

import 'package:personal_ai/models/chat_message.dart';
import 'package:personal_ai/providers/chat_socket_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'backend_rest_provider.dart';
import 'database_provider.dart';

part 'model_messages_provider.g.dart';

@Riverpod(keepAlive: true)
class ModelMessages extends _$ModelMessages {
  bool _isInitialized = false;

  FutureOr<List<ChatMessage>> _fetchMessages() async {
    final database = await ref.read(localDatabaseProvider.future);
    return await database.fetchMessages();
  }

  Future<void> _synchronizeWithBackend() async {
    state = await AsyncValue.guard(() async {
      print('Synchronizing with backend');
      final messageList = await future;

      print('Got message list for backend synchronization.');
      final queryParameters = <String, dynamic>{};
      if (messageList.isNotEmpty) {
        queryParameters['fromId'] = (messageList.map((e) => e.id).reduce(max) + 1).toString();
      } else {
        queryParameters['fromId'] = 0.toString();
      }
      final backendService = ref.read(backendRestServiceProvider);
      final messages = await backendService.get('chat', queryParameters);

      final jsonObject = jsonDecode(messages)['messages'] as List<dynamic>;
      final missingMessages = jsonObject.map((e) => ChatMessage.fromApi(e as Map<String, dynamic>)).toList();
      messageList.addAll(missingMessages);

      final database = await ref.read(localDatabaseProvider.future);
      database.upsertMessages(missingMessages);
      return messageList;
    });
  }
  
  Future<void> _startMessageSocketClient() async {
    final liveChats = ref.watch(socketChatMessageStreamProvider);
    liveChats.whenData((chatMessage) async {
      print('Received message from socket.');
      await update((messageList) async {
        messageList.add(chatMessage);

        final database = await ref.read(localDatabaseProvider.future);
        database.upsertMessage(chatMessage);

        return messageList;
      });
      },
    );
  }

  @override
  FutureOr<List<ChatMessage>> build() async {
    if(!_isInitialized) {
      print('Initializing chat messages observer.');
      _synchronizeWithBackend();
      _startMessageSocketClient();
      _isInitialized = true;
    }
    print('Building chat messages models.');
    return await _fetchMessages();
  }

  Future<void> sendMessage(ChatMessage message) async {
    await update((messageList) async {
      print('Sending message to socket.');
      final socketService = await ref.read(chatSocketServiceProvider.future);
      final database = await ref.read(localDatabaseProvider.future);
      final acknowledged = await socketService.sendMessage(message);
      messageList.add(acknowledged);

      database.upsertMessage(acknowledged);

      return messageList;
    });
  }
}
