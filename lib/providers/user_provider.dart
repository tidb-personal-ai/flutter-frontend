import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
User? user(UserRef ref) {
  final auth = FirebaseAuth.instance;
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    ref.state = user;
  });
  return auth.currentUser;
}
