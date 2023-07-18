import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:personal_ai/models/chat_message.dart';

class LocalDatabaseService {
  final Database _database;
  final String _storeName;

  LocalDatabaseService(this._database, this._storeName);

  Future<List<ChatMessage>> fetchMessages() async {
    final txn = _database.transaction(_storeName, idbModeReadOnly);
    final store = txn.objectStore(_storeName);
    final value = await store.getAll();
    await txn.completed;
    final messages = value.map((e) => ChatMessage.fromMap(e as Map)).toList();
    return messages;
  }

  Future<void> upsertMessage(ChatMessage message) async {
    final txn = _database.transaction(_storeName, idbModeReadWrite);
    final store = txn.objectStore(_storeName);
    await store.put(message.toMap(), message.id);
    await txn.completed;
  }

  Future<void> upsertMessages(List<ChatMessage> messages) async {
    for (final message in messages) {
      await upsertMessage(message);
    }
  }
}
