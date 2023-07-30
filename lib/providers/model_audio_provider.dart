
import 'dart:async';

import 'package:lumios/models/audio_message.dart';
import 'package:lumios/services/chat_socket_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'chat_socket_provider.dart';

part 'model_audio_provider.g.dart';

@Riverpod(keepAlive: true)
class ModelAudioMessages extends _$ModelAudioMessages {
  ChatSocketService? _socketService;
  AudioMessage? _latestAudioMessage;
  
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
      if(base64Message.id > (_latestAudioMessage?.id ?? 0)){
        print('Received newest audio message from socket.');
        _latestAudioMessage = base64Message;
        ref.invalidateSelf();
      }
    }
    print('BROKE AUDIO INFINITE LOOP!!!!!');
  }
  
  @override
  AudioMessage? build() {
    _startMessageSocketClient(ref.watch(chatSocketServiceProvider));

    print('Building audio messages models.');
    return _latestAudioMessage;
  }  

  Future<void> sendMessage(String base64Message) async {
    final socketService = await ref.read(chatSocketServiceProvider.future);
    if (socketService == null) {
      print('Socket service is null.');
      return;
    }
    print('Sending message to socket.');
    await socketService.sendAudio(base64Message);
  }
}
