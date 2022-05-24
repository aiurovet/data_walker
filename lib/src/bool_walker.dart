// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';

/// Class to walk through the booleans
///
class BoolWalker extends DataWalker<bool> {
  /// The constructor
  ///
  BoolWalker({super.repeats, super.isRandom, super.random}) : super(length: 2);

  /// Copy constructor
  ///
  BoolWalker copyWith({int? repeats, bool? isRandom, Random? random}) =>
      BoolWalker(
          repeats: repeats ?? this.repeats,
          isRandom: isRandom ?? this.isRandom,
          random: random ?? this.random);

  /// Move to the next value
  ///
  @override
  bool next([bool isNext = true]) => (nextNo(isNext) != 0);
}
