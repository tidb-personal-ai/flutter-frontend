import 'package:flutter/material.dart';
import 'package:personal_ai/providers/ai_provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.ai});
  
  final Ai ai;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Main'),
    );
  }
}
