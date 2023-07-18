
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

final actionCodeSettings = ActionCodeSettings(
  url: 'http://localhost:52614/#/',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'tidb.personal.ai',
);

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        ForgotPasswordAction((context, email) {
          Navigator.pushNamed(
            context,
            'forgot-password',
            arguments: {'email': email},
          );
        }),
        AuthStateChangeAction<SignedIn>((context, state) {
          if (!state.user!.emailVerified) {
            Navigator.pushNamed(context, 'verify-email');
          } else {
            Navigator.pushReplacementNamed(context, 'chat');
          }
        }),
        AuthStateChangeAction<UserCreated>((context, state) {
          if (!state.credential.user!.emailVerified) {
            Navigator.pushNamed(context, 'verify-email');
          } else {
            Navigator.pushReplacementNamed(context, 'chat');
          }
        }),
        AuthStateChangeAction<CredentialLinked>((context, state) {
          if (!state.user.emailVerified) {
            Navigator.pushNamed(context, 'verify-email');
          } else {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        }),
        EmailLinkSignInAction((context) {
          Navigator.pushReplacementNamed(context, 'email-link-sign-in');
        }),
      ],
      styles: const {
        EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
      },

      headerBuilder: (context, constraints, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 0.76142,
            child: Image.asset('assets/icon.png'),
          ),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: action == AuthAction.signIn
              ? const Text('Welcome to PersonalAI, please sign in!')
              : const Text('Welcome to PersonalAI, please sign up!'),
        );
      },
      footerBuilder: (context, action) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'By signing in, you agree to our terms and conditions.',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
      sideBuilder: (context, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 0.76142,
            child: Image.asset('assets/icon.png'),
          ),
        );
      },
    );
  }
}

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmailVerificationScreen(
      headerBuilder: (context, constraints, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 0.76142,
            child: Image.asset('assets/icon.png'),
          ),
        );
      },
      sideBuilder: (context, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 0.76142,
            child: Image.asset('assets/icon.png'),
          ),
        );
      },
      actions: [
        EmailVerifiedAction(() {
          Navigator.pushReplacementNamed(context, 'chat');
        }),
        AuthCancelledAction((context) {
          FirebaseUIAuth.signOut(context: context);
          Navigator.pushReplacementNamed(context, 'login');
        }),
      ],
    );
  }
}

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return ForgotPasswordScreen(
      email: arguments?['email'] as String?,
      headerMaxExtent: 200,
      headerBuilder: (context, constraints, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 0.76142,
            child: Image.asset('assets/icon.png'),
          ),
        );
      },
      sideBuilder: (context, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 0.76142,
            child: Image.asset('assets/icon.png'),
          ),
        );
      },
    );
  }
}
