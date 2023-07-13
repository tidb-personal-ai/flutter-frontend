import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return firebase_ui.ProfileScreen(
      actions: [
        firebase_ui.SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/login');
        }),
      ],
    );
  }
}