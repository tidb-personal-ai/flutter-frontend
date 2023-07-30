import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumios/providers/audio_provider.dart';

enum AudioScreenState {
  idle,
  loading,
  error,
  recording,
  playing,
  sending,
  waitingForResponse,
}

final audioScreenStateProvider = AutoDisposeStateProvider<AudioScreenState>((ref) {
  final audio = ref.watch(audioControllerProvider);
  if (audio.isLoading) {
    return AudioScreenState.loading;
  } else if (audio.hasError) {
    return AudioScreenState.error;  
  }
  return AudioScreenState.idle;
});

final audioIsPlayingProvider = AutoDisposeProvider<bool>((ref) {
  return ref.watch(audioScreenStateProvider.select((value) => value == AudioScreenState.playing));
});

final audioIsIdleProvider = AutoDisposeProvider<bool>((ref) {
  return ref.watch(audioScreenStateProvider.select((value) => value == AudioScreenState.idle));
});

final audioIsIdleOrRecordingProvider = AutoDisposeProvider<bool>((ref) {
  return ref.watch(audioScreenStateProvider.select((value) => value == AudioScreenState.recording || value == AudioScreenState.idle));
});
