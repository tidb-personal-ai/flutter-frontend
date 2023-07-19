
import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:personal_ai/models/chat_message.dart';
import 'package:personal_ai/providers/chat_socket_provider.dart';
import 'package:personal_ai/services/chat_socket_service.dart';
import 'package:personal_ai/services/local_database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'backend_rest_provider.dart';
import 'database_provider.dart';

part 'model_messages_provider.g.dart';

@Riverpod(keepAlive: true)
class ModelMessages extends _$ModelMessages {
  LocalDatabaseService? _database;
  ChatSocketService? _socketService;

  FutureOr<List<ChatMessage>> _fetchMessages() async {
    final database = await ref.read(localDatabaseProvider.future);
    return await database!.fetchMessages();
  }

  Future<void> _synchronizeWithBackend(AsyncValue<LocalDatabaseService?> value) async {
    final completer = Completer<LocalDatabaseService?>();
    value.whenData((value) => completer.complete(value));
    final database = await completer.future;
    if(_database == database) {
      return;
    } else {
      _database = database;
    }
    if(database == null) {
      print('Database is null.');
      return;
    }

    print('Synchronizing with backend');
    final messageList = await future;
    var missingMessages = List<ChatMessage>.empty();
    var firstLoop = true;

    print('Got message list for backend synchronization.');
    do {
      if (!firstLoop) {
        print('Waiting for 5 seconds before retrying.');
        await Future.delayed(const Duration(seconds: 5));
      }
      firstLoop = false;
      final queryParameters = <String, dynamic>{};
      if (messageList.isNotEmpty) {
        queryParameters['fromId'] = (messageList.map((e) => e.id).reduce(max) + 1).toString();
      } else {
        queryParameters['fromId'] = 0.toString();
      }
      final backendService = ref.read(backendRestServiceProvider);
      final messages = await backendService.get('chat', queryParameters);

      final jsonObject = jsonDecode(messages)['messages'] as List<dynamic>;
      missingMessages = jsonObject.map((e) => ChatMessage.fromApi(e as Map<String, dynamic>)).toList();
    } while (messageList.isEmpty && missingMessages.isEmpty);

    await database.upsertMessages(missingMessages);
    
    ref.invalidateSelf();
  }
  
  Future<void> _startMessageSocketClient(AsyncValue<ChatSocketService?> value) async {
    final completer = Completer<ChatSocketService?>();    
    value.whenData((value) => completer.complete(value));
    final socketService = await completer.future;
    if(_socketService == socketService) {
      return;
    } else {
      _socketService = socketService;
    }
    if(socketService == null) {
      print('Socket service is null.');
      return;
    }
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
    _synchronizeWithBackend(ref.watch(localDatabaseProvider));
    _startMessageSocketClient(ref.watch(chatSocketServiceProvider));

    print('Building chat messages models.');
    return await _fetchMessages();
  }

  Future<void> sendMessage(ChatMessage message) async {
    print('Sending message to socket.');
    final socketService = await ref.read(chatSocketServiceProvider.future);
    final database = await ref.read(localDatabaseProvider.future);
    final acknowledged = await socketService!.sendMessage(message);

    await database!.upsertMessage(acknowledged);
    ref.invalidateSelf();
  }
  
  Future<void> onMessageReceived(ChatMessage chatMessage) async {    
    final database = await ref.read(localDatabaseProvider.future);
    await database!.upsertMessage(chatMessage);
    ref.invalidateSelf();
  }
}
