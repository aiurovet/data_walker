// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';

/// Class to walk through the integers within the range
///
class IntWalker extends DataWalker<int> {
  /// Lowest possible value within the range
  ///
  final int min;

  /// Highest possible value within the range
  ///
  final int max;

  /// Increment to move from the previous value to the next one
  ///
  final int step;

  /// Default constructor
  ///
  IntWalker(this.min, this.max,
      {this.step = 1, super.repeats, super.isRandom, super.random})
      : super(length: (step == 0 ? 0 : ((max - min + step) ~/ step)));

  /// Copy constructor
  ///
  IntWalker copyWith(
          {int? min,
          int? max,
          int? step,
          int? repeats,
          bool? isRandom,
          Random? random}) =>
      IntWalker(min ?? this.min, max ?? this.max,
          step: step ?? this.step,
          repeats: repeats ?? this.repeats,
          isRandom: isRandom ?? this.isRandom,
          random: random ?? this.random);

  /// Move to the next value
  ///
  @override
  int next([bool isNext = true]) => min + nextNo(isNext) * step;
}
