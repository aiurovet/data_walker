// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';

/// Main entry point for the example
///
void main() {
  final l = [1, 2, 3];
  var w = IndexWalker.fromList(list: l, isRandom: true);

  for (var i = 0; i < 10; i++) {
    w.next();
    print('Test 1: ${l[w.cur as int]}');
  }

  w = IndexWalker(min: 1, max: 1.3, step: 0.1);

  for (var i = 0; i < 100; i++) {
    w.next();
    print('Test 2: ${w.cur}');
  }
}
