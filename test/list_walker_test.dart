// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var list = ['a', 1, 'b', true];
  var total = 0;
  var walkers = <ListWalker>[];

  setUp(() {
    walkers = [
      ListWalker(list, repeats: 3),
      ListWalker(list, repeats: 10, isRandom: true),
      ListWalker(list, repeats: 10, random: Random.secure()),
    ];
  });

  group('ListWalker', () {
    test('sequential', () {
      for (var walker in walkers.where((x) => !x.isRandom)) {
        total = 0;

        while (true) {
          final nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          expect(nextValue, list[walker.currentNo]);
        }

        expect(walker.length, list.length);
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

          expect(list.contains(nextValue), true);
        }

        expect(total, walker.repeats);
      }
    });
  });
}
