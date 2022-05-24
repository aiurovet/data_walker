// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

/// Class to organise supply of indices
///
abstract class DataWalker<T> {
  /// Current index
  ///
  int currentNo = -1;

  /// Flag showing there is no more iteration to go
  ///
  bool isFinished = false;

  /// Last index
  ///
  late final int lastNo;

  /// Last repeat index
  ///
  late final int lastRepeatNo;

  /// Number of sequential steps or the value for [random].nextInt()
  ///
  final int length;

  /// Get random index rather than increase sequentially
  ///
  late final bool isRandom;

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
      bool isRandom = false,
      Random? random,
      this.source}) {
    this.isRandom = isRandom || (random != null);
    this.random = random ?? Random();
    lastNo = length - 1;
    lastRepeatNo = repeats - 1;
    repeatNo = (this.isRandom ? -1 : 0);
  }

  /// Abstract: move to the next value
  ///
  T next([bool isNext = true]);

  /// Get the current value
  ///
  T current() => next(false);

  /// Set [currentNo] to the next value
  /// Increase [repeatNo] when [currentNo] reaches [length] and reset [currentNo]
  /// Returns -1 when [repeatNo] reaches [repeats]
  ///
  int nextNo([bool isNext = true]) {
    if (!isNext) {
      return currentNo;
    }

    if (repeatNo >= repeats) {
      isFinished = true;
      return currentNo;
    }

    if (isRandom) {
      currentNo = random.nextInt(length);
      ++repeatNo;
      isFinished = (repeatNo >= repeats);
    } else if (currentNo < lastNo) {
      ++currentNo;
    } else {
      currentNo = 0;
      ++repeatNo;
      isFinished = (repeatNo >= repeats);
    }

    return currentNo;
  }

  /// Reset [currentNo] and [repeatNo]
  ///
  void reset() {
    currentNo = -1;
    isFinished = false;
    repeatNo = (isRandom ? -1 : 0);
  }
}
