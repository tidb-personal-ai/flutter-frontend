import 'package:flutter/foundation.dart';
import 'package:idb_sqflite/idb_sqflite.dart';
import 'package:personal_ai/providers/user_provider.dart';
import 'package:personal_ai/services/local_database_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:idb_shim/idb_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<LocalDatabaseService?> localDatabase(LocalDatabaseRef ref) async {
  final user = ref.watch(userProvider);
  final storeName = user?.uid;
  print('Database opening for $storeName');
  if (storeName == null) {
    return null;
  }
  final factory = kIsWeb ? getIdbFactory() : getIdbFactorySqflite(sqflite.databaseFactory);
  final sharedPreferences = await SharedPreferences.getInstance();
  final version = sharedPreferences.getInt('database_version') ?? 1;
  final db = await factory!.open("personal_ai.db", version: version, onUpgradeNeeded: (e) {
      print('Upgrade needed');
      final db = e.database;
      if(!db.objectStoreNames.contains(storeName)) {
        print('Create object store');
        db.createObjectStore(storeName, autoIncrement: true);
      }
    },
  );
  sharedPreferences.setInt('database_version', version+1);
  ref.onDispose(() => db.close());
  print('Database opened');
  return LocalDatabaseService(db, storeName);
}
