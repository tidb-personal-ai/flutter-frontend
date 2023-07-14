import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_ai/providers/ai_provider.dart';
import 'package:personal_ai/screens/create_ai_screen.dart';
import 'package:personal_ai/screens/main_screen.dart';

class AiGateScreen extends ConsumerWidget {
  const AiGateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiProvider = ref.watch(aiProviderProvider);
    return aiProvider.when(
      data: (ai) => ai == null
        ? CreateAiScreen(aiProvider: aiProviderProvider.notifier)
        : MainScreen(ai: ai),
      error: (error, stack) => Center(
        child: Text('Error $error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
