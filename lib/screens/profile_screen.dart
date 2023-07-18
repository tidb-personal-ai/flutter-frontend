import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:random_avatar/random_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser!;

    return firebase_ui.ProfileScreen(
      avatar: RandomAvatar(user.uid, trBackground: true),
      actions: [
        firebase_ui.SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, 'login');
        }),
      ],
    );
  }
}
