// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';

/// Class to walk through the integers within the range
///
class DateTimeWalker extends DataWalker<DateTime> {
  /// The smallest possible value within the range
  ///
  final DateTime min;

  /// The largest possible value within the range
  ///
  final DateTime max;

  /// The increment to move from the previous value to the next one
  ///
  late final Duration step;

  /// The constructor
  ///
  DateTimeWalker(this.min, this.max,
      {Duration? step, super.repeats, super.isRandom, super.random})
      : super(
            length: ((step == null) || (step.inMicroseconds == 0)
                ? 0
                : ((max.microsecondsSinceEpoch -
                        min.microsecondsSinceEpoch +
                        step.inMicroseconds) ~/
                    step.inMicroseconds))) {
    this.step = step ?? Duration(microseconds: 0);
  }

  /// Move to the next value
  ///
  @override
  DateTime next([bool isNext = true]) =>
      min.add(Duration(microseconds: step.inMicroseconds * nextNo(isNext)));
}
