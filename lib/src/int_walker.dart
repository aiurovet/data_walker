// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

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

  /// The constructor
  ///
  IntWalker(this.min, this.max,
      {this.step = 1, super.repeats, super.isRandom, super.random})
      : super(length: (step == 0 ? 0 : ((max - min + step) ~/ step)));

  /// Get the current value
  ///
  @override
  int current() => (currentNo < 0 ? next() : min + currentNo * step);

  /// Move to the next value
  ///
  @override
  int next() => min + nextIndex() * step;

  /// Reset index and move to the first value
  ///
  @override
  int reset() => min + resetIndex() * step;
}
