// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioControllerHash() => r'5d54018672bb80236ebdc10132dd2b7daea5b07a';

/// See also [audioController].
@ProviderFor(audioController)
final audioControllerProvider =
    AutoDisposeFutureProvider<AudioController>.internal(
  audioController,
  name: r'audioControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioControllerRef = AutoDisposeFutureProviderRef<AudioController>;
String _$audioRecorderHash() => r'99aace313e7b00cb283092c430c0f418711ae118';

/// See also [audioRecorder].
@ProviderFor(audioRecorder)
final audioRecorderProvider =
    AutoDisposeFutureProvider<FlutterSoundRecorder>.internal(
  audioRecorder,
  name: r'audioRecorderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioRecorderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioRecorderRef = AutoDisposeFutureProviderRef<FlutterSoundRecorder>;
String _$audioPlayerHash() => r'9d65d527284af3b63dd045ff2823447d30d10a82';

/// See also [audioPlayer].
@ProviderFor(audioPlayer)
final audioPlayerProvider =
    AutoDisposeFutureProvider<FlutterSoundPlayer>.internal(
  audioPlayer,
  name: r'audioPlayerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$audioPlayerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioPlayerRef = AutoDisposeFutureProviderRef<FlutterSoundPlayer>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
