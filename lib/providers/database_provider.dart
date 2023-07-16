import 'package:flutter/foundation.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:idb_shim/idb_browser.dart';

part 'database_provider.g.dart';

const String storeName = 'chat_messages_store';

@riverpod
FutureOr<Database> getDatabaseInstance(GetDatabaseInstanceRef ref) async {
  final factory = kIsWeb ? getIdbFactory() : getIdbFactorySqflite(sqflite.databaseFactory);
  final db = await factory!.open("personal_ai.db", version: 1,
      onUpgradeNeeded: (VersionChangeEvent event) {
        final db = event.database;
        // create the store
        db.createObjectStore(storeName, autoIncrement: true);
      },
  );
  return db;
}
