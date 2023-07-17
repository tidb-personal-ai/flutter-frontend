// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_socket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$socketChatMessageStreamHash() =>
    r'695ef5f64c7e840ee5e5760a1559f20e9c361545';

/// See also [socketChatMessageStream].
@ProviderFor(socketChatMessageStream)
final socketChatMessageStreamProvider = StreamProvider<ChatMessage>.internal(
  socketChatMessageStream,
  name: r'socketChatMessageStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$socketChatMessageStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SocketChatMessageStreamRef = StreamProviderRef<ChatMessage>;
String _$chatSocketServiceHash() => r'87432709ab06347dd2a79ed66cf3295cf8f18636';

/// See also [chatSocketService].
@ProviderFor(chatSocketService)
final chatSocketServiceProvider = FutureProvider<ChatSocketService>.internal(
  chatSocketService,
  name: r'chatSocketServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chatSocketServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ChatSocketServiceRef = FutureProviderRef<ChatSocketService>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
