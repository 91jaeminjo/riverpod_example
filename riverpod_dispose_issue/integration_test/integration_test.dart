/// local_sync_test.dart
///
/// A top level integration test flow for syncing local changes.
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:riverpod_dispose_issue/main.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final widget = ProviderScope(
      overrides: [counterProvider.overrideWith((ref) => TestProvider())],
      child: const MyApp());

  group('Local sync integration tests', () {
    testWidgets('Sync point initially empty', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      expect(find.text('0'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    });
    testWidgets('Sync point initially empty', (WidgetTester tester) async {
      await Future.delayed(const Duration(seconds: 3));
      await tester.pumpWidget(widget);
      expect(find.text('0'), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);
    });
  });
}
