// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ai _$$_AiFromJson(Map<String, dynamic> json) => _$_Ai(
      name: json['name'] as String,
      traits:
          (json['traits'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_AiToJson(_$_Ai instance) => <String, dynamic>{
      'name': instance.name,
      'traits': instance.traits,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiProviderHash() => r'11ee008312a21f78edf404d490b43a63c5b7d216';

/// See also [AiProvider].
@ProviderFor(AiProvider)
final aiProviderProvider =
    AutoDisposeAsyncNotifierProvider<AiProvider, Ai?>.internal(
  AiProvider.new,
  name: r'aiProviderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$aiProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AiProvider = AutoDisposeAsyncNotifier<Ai?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
