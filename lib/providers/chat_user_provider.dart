import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'user_provider.dart';

part 'chat_user_provider.g.dart';

@riverpod
User? chatUser(ChatUserRef ref) {
  final user = ref.watch(userProvider);
  
  return user != null 
    ? User(
        firstName: user.displayName ?? user.email?.split('@').first ?? user.uid,
        id: user.uid,
        role: Role.user,
      )
    : null;
}
