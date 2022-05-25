// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';
import 'package:random_unicode/random_unicode.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  var total = 0;
  var nextValue = '';
  var walkers = <StringWalker>[];

  setUp(() {
    walkers = [
      StringWalker(RandomUnicode.ascii(), 20, 120),
      StringWalker(RandomUnicode(), 10, 32, stepLength: 3),
      StringWalker(RandomUnicode(), 10, 12, isRandomLength: true),
    ];
  });

  group('StringWalker - ', () {
    test('sequential', () {
      for (var walker in walkers.where((x) => !x.isRandom)) {
        total = 0;
        nextValue = '';

        while (true) {
          final prevValue = nextValue;
          nextValue = walker.next();

          if (walker.isFinished) {
            break;
          }

          ++total;

          if (walker.currentNo > 0) {
            final stepLength = nextValue.runes.length - prevValue.runes.length;
            expect(stepLength, walker.stepLength);
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
