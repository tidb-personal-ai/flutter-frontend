
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_ai/config/config.dart';
import 'package:personal_ai/models/chat_message.dart';
import 'package:personal_ai/services/chat_socket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'chat_socket_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<ChatMessage> socketChatMessageStream(SocketChatMessageStreamRef ref) async* {
  final socketService = await ref.watch(chatSocketServiceProvider.future);
  print('Socket stream opened');
  await for (final message in socketService.stream) {
    yield message;
  }
}

@Riverpod(keepAlive: true)
Future<ChatSocketService> chatSocketService(ChatSocketServiceRef ref) async {
  // Fetch the currentUser, and then get its id token 
  final user = FirebaseAuth.instance.currentUser!;
  final idToken = await user.getIdToken();
  
  final socket = io.io(Config.currentPlatform.socketUrl,
    io.OptionBuilder()
        .setTransports(['websocket'])
        .setQuery({'Authorization': 'Bearer $idToken'})
        .build(),
  );

  print('Socket opened');
  return ChatSocketService(socket);
}
