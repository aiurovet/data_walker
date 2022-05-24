// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var total = 0;
  var nextValue = false;
  var walkers = <BoolWalker>[];

  setUp(() {
    walkers = [
      BoolWalker(repeats: 2),
      BoolWalker(repeats: 10, isRandom: true),
      BoolWalker(repeats: 10, random: Random.secure()),
    ];
  });

  group('BoolWalker', () {
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
            expect(nextValue, !prevValue);
          }
        }

        expect(walker.length, 2);
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
