
import 'dart:async';
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
    return await database!.fetchMessages();
  }

  Future<void> _synchronizeWithBackend() async {
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

    final database = await ref.read(localDatabaseProvider.future);
    await database!.upsertMessages(missingMessages);
    
    ref.invalidateSelf();
  }
  
  Future<void> _startMessageSocketClient() async {    
    final socketService = await ref.watch(chatSocketServiceProvider.future);
    print('Socket stream opened');
    await for (final message in socketService.stream) {
      print('Received message from socket.');
      final database = await ref.read(localDatabaseProvider.future);
      await database!.upsertMessage(message);
      ref.invalidateSelf();
      print('Wait for next message.');
    }
    print('BROKE INFINITE LOOP!!!!!');
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
    print('Sending message to socket.');
    final socketService = await ref.read(chatSocketServiceProvider.future);
    final database = await ref.read(localDatabaseProvider.future);
    final acknowledged = await socketService.sendMessage(message);

    await database!.upsertMessage(acknowledged);
    ref.invalidateSelf();
  }
  
  Future<void> onMessageReceived(ChatMessage chatMessage) async {    
    final database = await ref.read(localDatabaseProvider.future);
    await database!.upsertMessage(chatMessage);
    ref.invalidateSelf();
  }
}
