import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart' show Level;

part 'audio_provider.g.dart';
part 'audio_provider.freezed.dart';

@freezed
class AudioController with _$AudioController {
  factory AudioController({
    required FlutterSoundRecorder recorder,
    required FlutterSoundPlayer player,
  }) = _AudioController;
}

@riverpod
FutureOr<AudioController> audioController(AudioControllerRef ref) async {
  final recorder = await ref.watch(audioRecorderProvider.future);
  final player = await ref.watch(audioPlayerProvider.future);
  await recorder.startRecorder(codec: Codec.opusWebM, toFile: 'foo.webm');
  await recorder.stopRecorder();
  return AudioController(recorder: recorder, player: player);
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
