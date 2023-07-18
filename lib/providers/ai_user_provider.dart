import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'ai_provider.dart';

part 'ai_user_provider.g.dart';

@riverpod
User? aiUser(AiUserRef ref) {
  final ai = ref.watch(aiProviderProvider)
    .maybeWhen(orElse: () => null, data: (ai) => ai);
  return ai == null ? null : User(
    firstName: ai.name,
    id: ai.name,
  );
}
