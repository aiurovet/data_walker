// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';

/// Main entry point for the example
///
void main() {
  final list = ['Str11', 'Str22', 'Str33'];

  var lw = ListWalker(list, repeats: 2);

  print('\n*** Sequential ***\n');

  while (lw.repeatNo < lw.repeats) {
    print('Next: ${lw.next()}, no: ${lw.currentNo}, rpt: ${lw.repeatNo}');
  }

  print('\n*** Random (secure) ***\n');

  lw = ListWalker(list, repeats: 10, random: Random.secure());

  while (lw.repeatNo < lw.repeats) {
    print('Next: ${lw.next()}, no: ${lw.currentNo}, rpt: ${lw.repeatNo}');
  }
}
