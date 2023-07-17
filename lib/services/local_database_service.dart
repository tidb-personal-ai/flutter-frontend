import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:personal_ai/models/chat_message.dart';
import 'package:personal_ai/providers/database_provider.dart';

class LocalDatabaseService {
  final Database _database;

  LocalDatabaseService(this._database);

  Future<List<ChatMessage>> fetchMessages() async {
    final txn = _database.transaction(storeName, idbModeReadOnly);
    final store = txn.objectStore(storeName);
    final value = await store.getAll();
    await txn.completed;
    final messages = value.map((e) => ChatMessage.fromMap(e as Map)).toList();
    return messages;
  }

  Future<void> upsertMessage(ChatMessage message) async {
    final txn = _database.transaction(storeName, idbModeReadWrite);
    final store = txn.objectStore(storeName);
    await store.put(message.toMap(), message.id);
    await txn.completed;
  }

  Future<void> upsertMessages(List<ChatMessage> messages) async {
    for (final message in messages) {
      await upsertMessage(message);
    }
  }
}
