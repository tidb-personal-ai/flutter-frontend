// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localDatabaseHash() => r'c77e4f2e95c127104b9b60896428b800b87bf95f';

/// See also [localDatabase].
@ProviderFor(localDatabase)
final localDatabaseProvider = FutureProvider<LocalDatabaseService?>.internal(
  localDatabase,
  name: r'localDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalDatabaseRef = FutureProviderRef<LocalDatabaseService?>;
String _$storeNameHash() => r'cfb7bf08de975b22ff2f993cd50604172e430f6c';

/// See also [storeName].
@ProviderFor(storeName)
final storeNameProvider = Provider<String?>.internal(
  storeName,
  name: r'storeNameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$storeNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StoreNameRef = ProviderRef<String?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
