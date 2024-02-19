import 'package:flutter_test/flutter_test.dart';
import 'package:counter_app/counter_app/model/counter.dart';

void main() {
  group('Testing the Counter class', () {
    test('Making sure that the class is correctly initialized', () {
      final counter = Counter();
      expect(counter.history.length, isZero);
      expect(counter.counter, isZero);
    });

    test('Making sure that values can be increased', () {
      final counter = Counter()
        ..increase()
        ..increase();
      expect(counter.history, orderedEquals(<int>[1, 2]));
      expect(counter.counter, equals(2));
    });

    test('Making sure that values can be decreased', () {
      final counter = Counter()
        ..increase()
        ..increase()
        ..decrease();
      expect(counter.history, orderedEquals(<int>[1, 2]));
      expect(counter.counter, equals(1));
    });

    test('Making sure that listeners are notified', () {
      var listenerCount = 0;
      final counter = Counter()..addListener(() => ++listenerCount);
      // Increase
      counter.increase();
      expect(listenerCount, equals(1));
      // Decrease
      counter.decrease();
      expect(listenerCount, equals(2));
    });
  });
}
