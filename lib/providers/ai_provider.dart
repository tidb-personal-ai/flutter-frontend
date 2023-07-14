import 'dart:convert';

import 'package:personal_ai/providers/backend_rest_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_provider.g.dart';
part 'ai_provider.freezed.dart';

@freezed
class Ai with _$Ai {
  factory Ai({
    required String name,
    required List<String> traits,
  }) = _Ai;

  factory Ai.fromJson(Map<String, dynamic> json) => _$AiFromJson(json);
}

@riverpod
class AiProvider extends _$AiProvider {
  Future<Ai?> _fetchAi() async {
    final backendService = ref.read(backendRestServiceProvider);
    final json = await backendService.get('ai');
    final ai = jsonDecode(json) as Map<String, dynamic>;
    if (ai['exists'] == true) {
      return Ai.fromJson(ai['ai'] as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  @override
  FutureOr<Ai?> build() async {
    // Load initial todo list from the remote repository
    return _fetchAi();
  }

  Future<void> createAi(String name, List<String> traits) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final backendService = ref.read(backendRestServiceProvider);
      final json = await backendService.post('ai/create', {
        'name': name,
        'traits': traits,
      });
      final ai = jsonDecode(json) as Map<String, dynamic>;
      return Ai.fromJson(ai);
    });
  }
}
