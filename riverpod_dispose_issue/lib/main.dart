import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// A Counter example implemented with riverpod

final counterProvider =
    StateNotifierProvider<TestProvider, int>((_) => throw UnimplementedError());

void main() {
  final counter = TestProvider();
  runApp(
    // Adding ProviderScope enables Riverpod for the entire project
    ProviderScope(
        overrides: [counterProvider.overrideWith((ref) => counter)],
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _Home());
  }
}

class _Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter example')),
      body: Center(
        // Consumer is a widget that allows you reading providers.
        child: Consumer(
          builder: (context, ref, _) {
            final count = ref.watch(counterProvider);
            return Text('$count');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // The read method is a utility to read a provider without listening to it
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TestProvider extends StateNotifier<int> {
  int _count;

  TestProvider()
      : _count = 0,
        super(0);

  void increment() {
    _count++;
    state = _count;
  }
}
