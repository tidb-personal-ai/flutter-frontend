// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAdminHash() => r'73cc912ec6943d32a6134d1b7202e322735ca8a3';

/// See also [isAdmin].
@ProviderFor(isAdmin)
final isAdminProvider = AutoDisposeFutureProvider<bool>.internal(
  isAdmin,
  name: r'isAdminProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsAdminRef = AutoDisposeFutureProviderRef<bool>;
String _$userHash() => r'bf2338e00b61c0b56e9cfe94b699799e47fd85ba';

/// See also [user].
@ProviderFor(user)
final userProvider = Provider<User?>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = ProviderRef<User?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
