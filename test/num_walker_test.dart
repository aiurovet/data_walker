// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var total = 0;
  num nextValue = 0.0;
  var walkers = <NumWalker>[];

  setUp(() {
    walkers = [
      NumWalker(0.05, 0.10, step: 0.02, repeats: 3),
      NumWalker(0.10, 0.05, step: -0.02, repeats: 2),
      NumWalker(0.01, 1.00, repeats: 10, isRandom: true),
      NumWalker(0.01, 1.00, repeats: 10, random: Random.secure()),
    ];
  });

  group('NumWalker', () {
    test('sequential', () {
      for (var walker in walkers.where((x) => !x.isRandom)) {
        total = 0;
        final stepStr = walker.step.toStringAsFixed(4);

        while (true) {
          final prevValue = nextValue;
          nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          if (walker.currentNo > 0) {
            expect((nextValue - prevValue).toStringAsFixed(4), stepStr);
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
