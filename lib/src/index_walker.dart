// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

/// Class to organise supply of indices
///
class IndexWalker {
  /// Current value
  ///
  int current = 0;

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

  /// How many times to repeat [length] increments
  ///
  final int runCount;

  /// Current repeat number
  ///
  int runNo = 0;

  /// Anything to store for sub-classes
  ///
  final Object? source;

  /// Increment
  ///
  static IndexWalker fromList<T>({List<T>? list, bool isRandom = false, Random? random}) =>
    IndexWalker(length: list?.length ?? 0, random: random, isRandom: isRandom, source: list);

  /// The constructor
  ///
  IndexWalker({this.length = 0, this.runCount = 1, this.isRandom = false, Random? random, this.source}) {
    this.random = random ?? Random();
  }

  /// Set [current] to the next value
  /// Increase [runNo] when [current] reaches [length] and reset [current]
  /// Returns -1 when [runNo] reaches [runCount]
  ///
  int nextIndex() {
    if (runNo >= runCount) {
      isDone = true;
    } else {
      if (isRandom) {
        current = random.nextInt(length);
        ++runNo;
      } else if (current >= length) {
        current = 0;
        ++runNo;
      } else {
        ++current;
      }
    }

    return current;
  }

  /// Reset [current], [isDone] and [runNo]
  ///
  int resetIndex() {
    current = 0;
    runNo = 0;
    isDone = false;

    return current;
  }
}
