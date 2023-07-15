import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_user_provider.g.dart';

@riverpod
User chatUser(ChatUserRef ref) {
  final auth = firebase_auth.FirebaseAuth.instance;
  final user = auth.currentUser!;
  
  return User(
    firstName: user.displayName ?? user.email?.split('@').first ?? user.uid,
    id: user.uid,
    role: Role.user,
  );
}
