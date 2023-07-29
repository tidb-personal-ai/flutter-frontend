// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$audioMessageAvailableHash() =>
    r'2d4d3c4c0820cae220391f257b97e5125dc7b2f7';

/// See also [audioMessageAvailable].
@ProviderFor(audioMessageAvailable)
final audioMessageAvailableProvider = AutoDisposeProvider<bool>.internal(
  audioMessageAvailable,
  name: r'audioMessageAvailableProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioMessageAvailableHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioMessageAvailableRef = AutoDisposeProviderRef<bool>;
String _$audioMessageStateHash() => r'0b7cde2ae6c86ce520885ac3b868a25a7ef4f63a';

/// See also [AudioMessageState].
@ProviderFor(AudioMessageState)
final audioMessageStateProvider =
    AutoDisposeNotifierProvider<AudioMessageState, AudioMessage?>.internal(
  AudioMessageState.new,
  name: r'audioMessageStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioMessageStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioMessageState = AutoDisposeNotifier<AudioMessage?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
