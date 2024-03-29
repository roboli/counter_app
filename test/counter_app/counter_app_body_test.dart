import 'package:counter_app/counter_app/counter_app_body.dart';
import 'package:counter_app/counter_app/widgets/app_title.dart';
import 'package:counter_app/counter_app/widgets/history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../mock_wrapper.dart';

void main() {
  group('Testing Counter app widget', () {
    testWidgets('Making sure that the widget is rendered', (tester) async {
      await tester.pumpWidget(const MockWrapper(child: CounterAppBody()));

      expect(find.byType(CounterAppBody), findsOneWidget);
      expect(find.byType(AppTitle), findsOneWidget);
      expect(find.byType(HistoryWidget), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(2));
    });

    testWidgets('Making sure that the counter can be updated', (tester) async {
      await tester.pumpWidget(const MockWrapper(child: CounterAppBody()));
      final decreaseKey = find.byKey(const Key('ElevatedButton-Decrease'));
      final increaseKey = find.byKey(const Key('ElevatedButton-Increase'));
      // 0 is the default counter value
      expect(find.text('0'), findsOneWidget);
      // Increasing by 1
      await tester.tap(increaseKey);
      await tester.pumpAndSettle();
      // Finds the counter text and the entry in the history
      // list
      expect(find.text('1'), findsNWidgets(2));
      // Decreasing by 2
      await tester.tap(decreaseKey);
      await tester.tap(decreaseKey);
      await tester.pumpAndSettle();
      // Only the counter has negative values, the history
      // doesn't
      expect(find.text('-1'), findsOneWidget);
    });

    testGoldens('CounterAppBody no history - golder', (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'No history',
          const SizedBox(
            width: 400,
            height: 400,
            child: MockWrapper(child: CounterAppBody()),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(400, 600),
      );

      await screenMatchesGolden(tester, 'counter_app_body_no_history');
    });

    testGoldens('CounterAppBody with history - golden', (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'No history',
          const SizedBox(
            width: 400,
            height: 400,
            child: MockWrapper(child: CounterAppBody()),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(400, 600),
      );

      await screenMatchesGolden(tester, 'counter_app_body_with_history',
          customPump: (tester) async {
        final increaseKey = find.byKey(const Key('ElevatedButton-Increase'));
        await tester.tap(increaseKey);
        await tester.tap(increaseKey);
        await tester.pumpAndSettle();
      });
    });
  });
}
