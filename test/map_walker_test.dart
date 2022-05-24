// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var map = {'a': 'a', 'n': 1, 'b': 'b', 'flag': true};
  var total = 0;
  var walkers = <MapWalker>[];

  setUp(() {
    walkers = [
      MapWalker(map, repeats: 3),
      MapWalker(map, repeats: 10, isRandom: true),
      MapWalker(map, repeats: 10, random: Random.secure()),
    ];
  });

  group('MapWalker', () {
    test('sequential', () {
      for (var walker in walkers.where((x) => !x.isRandom)) {
        total = 0;

        while (true) {
          final nextValue = walker.next() as MapEntry<String, dynamic>;

          if (walker.isFinished) {
            break;
          }

          ++total;

          expect(nextValue.value, map[nextValue.key]);
        }

        expect(walker.length, map.length);
        expect(total, walker.length * walker.repeats);
      }
    });
    test('random', () {
      for (var walker in walkers.where((x) => x.isRandom)) {
        total = 0;

        while (true) {
          var nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          expect(map[nextValue.key], nextValue.value);
        }

        expect(total, walker.repeats);
      }
    });
  });
}
