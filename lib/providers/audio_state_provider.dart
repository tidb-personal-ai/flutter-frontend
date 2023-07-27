import 'dart:convert';
import 'dart:typed_data' show Uint8List;
import 'dart:html';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lumios/providers/model_audio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'audio_state_provider.g.dart';
part 'audio_state_provider.freezed.dart';

@freezed
class AudioMessage with _$AudioMessage {
  factory AudioMessage({
    required Uint8List data,
  }) = _AudioMessage;

  factory AudioMessage.fromBase64(String base64Data) => AudioMessage(data: base64Decode(base64Data));
}

@riverpod
class AudioMessageState extends _$AudioMessageState {
  @override
  AudioMessage? build() {
    final message = ref.watch(modelAudioMessagesProvider);
    return message == null ? null : AudioMessage.fromBase64(message);
  }

  Future<void> sendMessage(String messageKey) async {
    if (!kIsWeb) {
      throw UnimplementedError();
    }
    final url = window.sessionStorage[messageKey]!;
    final data = await http.get(Uri.parse(url));
    final base64Data = base64Encode(data.bodyBytes);
    window.sessionStorage.remove(messageKey);
    await ref.read(modelAudioMessagesProvider.notifier).sendMessage(base64Data);
    print('Audio message send.');
  }
}
