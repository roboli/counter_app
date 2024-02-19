import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  // Load fonts for golden tests
  setUpAll(() async {
    await loadAppFonts();
  });

  // Test main body
  await testMain();
}
