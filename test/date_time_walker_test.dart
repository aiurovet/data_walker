// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var total = 0;
  var nextValue = DateTime.now();
  var walkers = <DateTimeWalker>[];

  setUp(() {
    walkers = [
      DateTimeWalker(DateTime(2022, 1, 2), DateTime(2022, 2, 2),
          step: Duration(days: 3), repeats: 3),
      DateTimeWalker(DateTime(2022, 2, 2), DateTime(2022, 1, 2),
          step: Duration(days: -3), repeats: 2),
      DateTimeWalker(DateTime(2022, 1, 2), DateTime(2022, 2, 2),
          repeats: 3, isRandom: true),
      DateTimeWalker(DateTime(2022, 1, 2), DateTime(2022, 2, 2),
          repeats: 3, random: Random.secure()),
    ];
  });

  group('DateTimeWalker', () {
    test('sequential', () {
      for (var walker in walkers.where((x) => !x.isRandom)) {
        total = 0;

        final stepInMicroseconds = walker.step.inMicroseconds;

        while (true) {
          final prevValue = nextValue;
          nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          if (walker.currentNo > 0) {
            final diff = nextValue.microsecondsSinceEpoch -
                prevValue.microsecondsSinceEpoch;
            expect(diff, stepInMicroseconds);
          }
        }

        expect(total, walker.length * walker.repeats);
      }
    });
    test('random', () {
      for (var walker in walkers.where((x) => x.isRandom)) {
        total = 0;

        while (true) {
          walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;
        }

        expect(total, walker.repeats);
      }
    });
  });
}
