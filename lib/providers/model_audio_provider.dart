
import 'dart:async';

import 'package:lumios/services/chat_socket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'chat_socket_provider.dart';

part 'model_audio_provider.g.dart';

@Riverpod(keepAlive: true)
class ModelAudioMessages extends _$ModelAudioMessages {
  ChatSocketService? _socketService;
  String? latestAudioMessage;
  
  Future<void> _startMessageSocketClient(AsyncValue<ChatSocketService?> value) async {
    final completer = Completer<ChatSocketService?>();    
    value.whenData((value) => completer.complete(value));
    final socketService = await completer.future;
    if(_socketService == socketService) {
      return;
    } else {
      _socketService = socketService;
    }
    if(socketService == null) {
      print('Socket service is null.');
      return;
    }
    print('Audio socket stream opened');
    await for (final base64Message in socketService.audioStream) {
      print('Received message from audio socket.');
      latestAudioMessage = base64Message;
      ref.invalidateSelf();
    }
    print('BROKE AUDIO INFINITE LOOP!!!!!');
  }
  
  @override
  String? build() {
    _startMessageSocketClient(ref.watch(chatSocketServiceProvider));

    print('Building audio messages models.');
    return latestAudioMessage;
  }  

  Future<void> sendMessage(String base64Message) async {
    print('Sending message to socket.');
    final socketService = await ref.read(chatSocketServiceProvider.future);
    await socketService!.sendAudio(base64Message);
  }
}
