import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' show Level;
import 'package:uuid/uuid.dart';

part 'audio_provider.g.dart';

class AudioController {
  final FlutterSoundRecorder _recorder;
  final FlutterSoundPlayer _player;
  String _recorderKey = '';

  AudioController(this._recorder, this._player);

  Future<void> startRecorder() async {
    _recorderKey = '${const Uuid().v4()}.webm';
    await _recorder.startRecorder(codec: Codec.opusWebM, toFile: _recorderKey);
  }

  Future<String> stopRecorder() async {
    await _recorder.stopRecorder();
    return _recorderKey;
  }

  Future<void> startPlayer({
    required Uint8List fromDataBuffer,
    required Codec codec,
    required void Function() whenFinished,
  }) async {
    await _player.startPlayer(
      fromDataBuffer: fromDataBuffer,
      whenFinished: whenFinished,
      codec: codec,
    );
  }

  Future<void> stopPlayer() async {
    await _player.stopPlayer();
  }
}

@riverpod
FutureOr<AudioController> audioController(AudioControllerRef ref) async {
  final recorder = await ref.watch(audioRecorderProvider.future);
  final player = await ref.watch(audioPlayerProvider.future);
  await recorder.startRecorder(codec: Codec.opusWebM, toFile: 'foo.webm');
  await recorder.stopRecorder();
  return AudioController(recorder, player);
}

@riverpod
FutureOr<FlutterSoundRecorder> audioRecorder(AudioRecorderRef ref) async {
  final recorder = FlutterSoundRecorder(logLevel: Level.warning);
  await recorder.openRecorder();
  ref.onDispose(() async { recorder.closeRecorder(); });
  return recorder;
}

@riverpod
FutureOr<FlutterSoundPlayer> audioPlayer(AudioPlayerRef ref) async {
  final player = FlutterSoundPlayer(logLevel: Level.warning);
  await player.openPlayer();
  ref.onDispose(() async { player.closePlayer(); });
  return player;
}
