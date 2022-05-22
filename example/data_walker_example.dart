// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';

/// Custom Color class for the example
///
enum Color {
  black,
  blue,
  yellow,
  white;

  @override
  String toString() => name;
}

/// Custom IconColor class for the example
///
class IconColors {
  final Color fg;
  final Color bg;
  IconColors(this.fg, this.bg);
  @override
  String toString() => '$fg on $bg';
}

/// Custom IconSizePrice class for the example
///
class IconSizePrice {
  final int size;
  final num price;
  IconSizePrice(this.size, this.price);
  @override
  String toString() => '$size x $size, Price: \$${price.toStringAsFixed(2)}';
}

/// Main entry point for the example
///
void main() {
  print('\n*** Sequential Aggregated ListWalkers ***\n');

  final walkers = <String, DataWalker>{
    'Icon': ListWalker<String>([
      'new',
      'open',
      'save',
      'edit',
      'find',
      'replace',
    ]),
    'Colors': ListWalker<IconColors>([
      IconColors(Color.black, Color.white),
      IconColors(Color.white, Color.black),
      IconColors(Color.yellow, Color.blue),
      IconColors(Color.blue, Color.yellow),
    ]),
    'Size': ListWalker<IconSizePrice>([
      IconSizePrice(16, 0.10),
      IconSizePrice(24, 0.15),
      IconSizePrice(32, 0.20),
      IconSizePrice(48, 0.25),
      IconSizePrice(64, 0.30),
      IconSizePrice(80, 0.35),
      IconSizePrice(96, 0.40),
    ])
  };

  walkers.exec(
      repeats: 1,
      valueProc: (values) {
        print(walkers.valuesToString(values, useKeys: false));
        return true;
      });

  print('\n*** Sequential Plain NumWalker ***\n');

  var walker = NumWalker(0.1, 1.0, step: 0.05, repeats: 2);

  while (true) {
    final n = walker.next().toStringAsFixed(2);

    if (walker.repeatNo >= walker.repeats) {
      break;
    }

    print('r:${walker.repeatNo + 1}, #${walker.currentNo + 1}: $n');
  }

  print('\n*** Random Plain NumWalker ***\n');

  walker = walker.copyWith(repeats: 10, random: Random.secure());

  while (true) {
    final n = walker.next().toStringAsFixed(2);

    if (walker.repeatNo >= walker.repeats) {
      break;
    }

    print('r:${walker.repeatNo + 1}, #${walker.currentNo + 1}: $n');
  }
}
