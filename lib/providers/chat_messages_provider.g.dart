// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$typingUsersHash() => r'40e8dd88276a8aeb5e61aa70be6a9a5e8d4905a7';

/// See also [typingUsers].
@ProviderFor(typingUsers)
final typingUsersProvider = AutoDisposeProvider<List<User>>.internal(
  typingUsers,
  name: r'typingUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$typingUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TypingUsersRef = AutoDisposeProviderRef<List<User>>;
String _$isLoadingHash() => r'b995a5a9357d6f000680e6a46eee2b846194d174';

/// See also [isLoading].
@ProviderFor(isLoading)
final isLoadingProvider = AutoDisposeProvider<bool>.internal(
  isLoading,
  name: r'isLoadingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsLoadingRef = AutoDisposeProviderRef<bool>;
String _$chatMessagesHash() => r'15862bbe129195bc408b447f7a200819e4a938d3';

/// See also [ChatMessages].
@ProviderFor(ChatMessages)
final chatMessagesProvider =
    AutoDisposeNotifierProvider<ChatMessages, List<Message>>.internal(
  ChatMessages.new,
  name: r'chatMessagesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatMessages = AutoDisposeNotifier<List<Message>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
