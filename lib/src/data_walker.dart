// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

/// Class to organise supply of indices
///
abstract class DataWalker<T> {
  /// Current index
  ///
  int currentNo = -1;

  /// Last index
  ///
  late final int lastNo;

  /// Last repeat index
  ///
  late final int lastRepeatNo;

  /// Number of sequential steps or the value for [random].nextInt()
  ///
  final int length;

  /// Flag indicating the walk is over
  ///
  bool isDone = false;

  /// Get random index rather than increase sequentially
  ///
  final bool isRandom;

  /// Random number generator
  ///
  late final Random random;

  /// Current repeat number
  ///
  int repeatNo = 0;

  /// How many times to repeat [length] increments
  ///
  final int repeats;

  /// Anything to store for sub-classes
  ///
  final Object? source;

  /// The constructor
  ///
  DataWalker(
      {this.length = 0,
      this.repeats = 1,
      this.isRandom = false,
      Random? random,
      this.source}) {
    this.random = random ?? Random();
    lastNo = length - 1;
    lastRepeatNo = repeats - 1;
  }

  /// Abstract: get the current value
  ///
  T current();

  /// Abstract: move to the next value
  ///
  T next();

  /// Abstract: reset the index and move to the first value
  ///
  T reset();

  /// Set [currentNo] to the next value
  /// Increase [repeatNo] when [currentNo] reaches [length] and reset [currentNo]
  /// Returns -1 when [repeatNo] reaches [repeats]
  ///
  int nextIndex() {
    if (repeatNo >= repeats) {
      isDone = true;
    } else {
      if (isRandom) {
        currentNo = random.nextInt(length);
        ++repeatNo;
      } else if (currentNo < lastNo) {
        ++currentNo;
      } else if ((++repeatNo) < repeats) {
        currentNo = 0;
      }
    }

    return currentNo;
  }

  /// Reset [currentNo], [isDone] and [repeatNo]
  ///
  int resetIndex() {
    currentNo = 0;
    repeatNo = 0;
    isDone = false;

    return currentNo;
  }
}
