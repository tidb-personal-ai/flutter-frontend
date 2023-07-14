import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_ai/app.dart';

import 'package:personal_ai/config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FlutterError.presentError(FlutterErrorDetails(exception: error, stack: stack));
    return true;
  };

  FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      GoogleProvider(
        clientId: '801432512124-8fsb5bjk5uieduft6f3ti5pv292hpi5v.apps.googleusercontent.com',
        redirectUri: 'http://localhost:52614/#/__/auth/handler',
      ),
  ]);
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(
      child: PersonalAiApp(),
    ),
  );
}
