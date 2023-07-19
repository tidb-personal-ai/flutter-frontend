import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
User? user(UserRef ref) {
  final auth = FirebaseAuth.instance;
  final subscription = FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (ref.state?.uid != user?.uid) {
      ref.invalidateSelf();
      print('User state invalidated: ${user?.uid}');
    }
  });
  ref.onDispose(() { 
    print('User subscription cancelled.');
    subscription.cancel();
  });
  print('New user state: ${auth.currentUser?.uid}');
  return auth.currentUser;
}
