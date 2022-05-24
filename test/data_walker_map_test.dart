// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';
import 'package:test/test.dart';

/// Tests entry point
///
void main() {
  Map<String, DataWalker> walkers = {};

  setUp(() {
    walkers = <String, DataWalker>{
      's1': ListWalker<String>([
        's11',
        's12',
        's13',
      ]), // 3
      'i1': IntWalker(1, 11, step: 2, repeats: 3), // 6 * 3 = 18
      'f1': NumWalker(0.1, 2.2, step: 0.3, repeats: 2), // 8 * 2 = 16
    };
  });

  group('DataWalkerMap -', () {
    test('exec', () {
      var count = 0;
      walkers.exec(
          repeats: 2,
          valueProc: (values) {
            ++count;
          });

      expect(count, ((3 * (6 * 3) * (8 * 2))) * 2);
    });
    test('valuesToString', () {
      walkers = <String, DataWalker>{
        'data': ListWalker(
          [
            {'s1': 's11', 'i3': 3, 'f2': 0.7},
            {'s2': 's20', 'i4': -1, 'f3': 0.05}
          ],
        ),
        'useKeys': BoolWalker(),
        'quoteStrings': BoolWalker(),
      };

      final expected = [
        's11, 3, 0.7',
        '"s11", 3, 0.7',
        's1: s11, i3: 3, f2: 0.7',
        's1: "s11", i3: 3, f2: 0.7',
        's20, -1, 0.05',
        '"s20", -1, 0.05',
        's2: s20, i4: -1, f3: 0.05',
        's2: "s20", i4: -1, f3: 0.05',
      ];

      walkers.exec(
          repeats: 3,
          valueProc: (values) {
            final i = walkers['data']!.currentNo * 4 +
                walkers['useKeys']!.currentNo * 2 +
                walkers['quoteStrings']!.currentNo;
            final result = walkers.valuesToString(values['data'],
                useKeys: values['useKeys'],
                quoteStrings: values['quoteStrings']);
            expect(result, expected[i]);
          });
    });
  });
}
