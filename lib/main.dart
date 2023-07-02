import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:personal_ai/auth_gate.dart';

import 'firebase_options.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );

FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    emailLinkProviderConfig,
    GoogleProvider(
      clientId: '801432512124-8fsb5bjk5uieduft6f3ti5pv292hpi5v.apps.googleusercontent.com',
      redirectUri: 'http://localhost:52614/#/__/auth/handler' 
    ),
 ]);
 runApp(const AuthGatedApp());
}
