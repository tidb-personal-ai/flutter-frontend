
import 'dart:convert';
import 'dart:math';

import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:personal_ai/models/chat_message.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'backend_rest_provider.dart';
import 'database_provider.dart';

part 'model_messages_provider.g.dart';

@riverpod
@Riverpod(keepAlive: true)
class ModelMessages extends _$ModelMessages {
  FutureOr<List<ChatMessage>> _fetchMessages() async {
    final database = await ref.watch(getDatabaseInstanceProvider.future);
    final txn = database.transaction(storeName, idbModeReadOnly);
    final store = txn.objectStore(storeName);
    final value = await store.getAll();
    await txn.completed;
    final messages = value.map((e) => ChatMessage.fromMap(e as Map)).toList();
    await _synchronizeWithBackend(messages, database);
    return messages;
  }

  Future<void> _synchronizeWithBackend(List<ChatMessage> lastKnownMessages, Database database) async {
    final queryParameters = <String, dynamic>{};
    if (lastKnownMessages.isNotEmpty) {
      queryParameters['fromId'] = (lastKnownMessages.map((e) => e.id).reduce(max) + 1).toString();
    } else {
      queryParameters['fromId'] = 0.toString();
    }
    final backendService = ref.read(backendRestServiceProvider);
    final messages = await backendService.get('chat', queryParameters);
    final jsonObject = jsonDecode(messages)['messages'] as List<dynamic>;
    final missingMessages = jsonObject.map((e) => ChatMessage.fromApi(e as Map<String, dynamic>)).toList();
    lastKnownMessages.addAll(missingMessages);
    for (final message in missingMessages) {
      final txn = database.transaction(storeName, idbModeReadWrite);
      final store = txn.objectStore(storeName);
      await store.put(message.toMap());
      await txn.completed;
    }
  }

  @override
  FutureOr<List<ChatMessage>> build() async {
    //TODO Start web socket client and listen for chat events
    return await _fetchMessages();
  }
}
