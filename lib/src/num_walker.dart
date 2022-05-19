// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';

/// Class to walk through the integers within the range
///
class NumWalker extends DataWalker<num> {
  /// Lowest possible value within the range
  ///
  final num min;

  /// Highest possible value within the range
  ///
  final num max;

  /// Increment to move from the previous value to the next one
  ///
  final num step;

  /// The constructor
  ///
  NumWalker(this.min, this.max,
      {this.step = 1, super.repeats, super.isRandom, super.random})
      : super(length: (step == 0 ? 0 : ((max - min + step) / step).round()));

  /// Get the current value
  ///
  @override
  num current() => (currentNo < 0 ? next() : min + currentNo * step);

  /// Move to the next value
  ///
  @override
  num next() => min + nextIndex() * step;

  /// Reset index and move to the first value
  ///
  @override
  num reset() => min + resetIndex() * step;
}
