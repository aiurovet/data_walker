// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var total = 0;
  var nextValue = 0;
  var walkers = <IntWalker>[];

  setUp(() {
    walkers = [
      IntWalker(5, 10, step: 2, repeats: 3),
      IntWalker(10, 5, step: -2, repeats: 2),
      IntWalker(1, 100, repeats: 10, isRandom: true),
      IntWalker(1, 100, repeats: 10, random: Random.secure()),
    ];
  });

  group('IntWalker', () {
    test('sequential', () {
      for (var walker in walkers.where((x) => !x.isRandom)) {
        total = 0;

        while (true) {
          final prevValue = nextValue;
          nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          if (walker.currentNo > 0) {
            expect(nextValue - prevValue, walker.step);
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
