import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_ai/providers/auth_provider.dart';
import 'package:personal_ai/screens/auth_screens.dart';
import 'package:personal_ai/screens/home_screen.dart';

class PersonalAiApp extends ConsumerWidget {
  const PersonalAiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    final String initialRoute = ref.watch(initialRouteProvider);

    return MaterialApp(
        title: 'Luni',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          visualDensity: VisualDensity.standard,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
          textButtonTheme: TextButtonThemeData(style: buttonStyle),
          outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
        ),
        initialRoute: initialRoute,
        routes: {
        '/': (context) => const MyHomePage(title: 'Personal AI'),
        '/login':(context) => const LoginScreen(),
        '/verify-email': (context) => const VerifyEmailScreen(),
        '/forgot-password':(context) => const PasswordResetScreen(),
        },
      );
  }
}