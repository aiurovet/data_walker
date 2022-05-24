// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var iterable = ['a', 1, 'b', true];
  var total = 0;
  var walkers = <IterableWalker>[];

  setUp(() {
    walkers = [
      IterableWalker(iterable, repeats: 3),
      IterableWalker(iterable, repeats: 10, isRandom: true),
      IterableWalker(iterable, repeats: 10, random: Random.secure()),
    ];
  });

  group('IterableWalker', () {
    test('sequential', () {
      for (var walker in walkers.where((x) => !x.isRandom)) {
        total = 0;

        while (true) {
          final nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          expect(nextValue, iterable[walker.currentNo]);
        }

        expect(walker.length, iterable.length);
        expect(total, walker.length * walker.repeats);
      }
    });
    test('random', () {
      for (var walker in walkers.where((x) => x.isRandom)) {
        total = 0;

        while (true) {
          final nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          expect(iterable.contains(nextValue), true);
        }

        expect(total, walker.repeats);
      }
    });
  });
}
