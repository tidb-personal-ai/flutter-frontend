import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
String initialRoute(InitialRouteRef ref) {
  final auth = FirebaseAuth.instance;

  if (auth.currentUser == null) {
    return '/login';
  }

  if (!auth.currentUser!.emailVerified && auth.currentUser!.email != null) {
    return '/verify-email';
  }

  return '/';
}
