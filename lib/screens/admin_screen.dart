import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lumios/providers/keyword_search_provider.dart';
import 'package:lumios/providers/user_provider.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isAdminProvider).when(
      data: (isAdmin) => isAdmin
        ? Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Admin View')),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Keyword',
                      ),
                      onSubmitted: (value) {
                        ref.read(keywordSearchProvider.notifier).search(value);
                      },
                    ),
                    const SizedBox(height: 30),
                    ref.watch(keywordSearchProvider).when(
                      data: (data) => data != null ? Text('Keyword count: $data', style: Theme.of(context).textTheme.headlineSmall) : Container(), 
                      error: (error, stack) => Center(
                        child: Text('Error $error'),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        : const Center(
          child: Text('You are not an admin, what are you doing here?'),
        ),
      error: (error, stack) => Center(
        child: Text('Error $error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
