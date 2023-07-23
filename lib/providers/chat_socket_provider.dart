
import 'dart:async';

import 'package:lumios/config/config.dart';
import 'package:lumios/providers/user_provider.dart';
import 'package:lumios/services/chat_socket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'chat_socket_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ChatSocketService?> chatSocketService(ChatSocketServiceRef ref) async {
  final user = ref.watch(userProvider);
  final idToken = await user?.getIdToken();
  print('Socket opening for ${user?.uid}');
  if (idToken == null) {
    return null;
  }
  
  final socket = io.io(Config.currentPlatform.socketUrl,
    io.OptionBuilder()
        .setTransports(['websocket'])
        .setAuth({'Authorization': 'Bearer $idToken'})
        .enableForceNewConnection()
        .enableReconnection()
        .build(),
  );

  ref.onDispose(() => socket.close());
  print('Socket opened');
  return ChatSocketService(socket);
}
