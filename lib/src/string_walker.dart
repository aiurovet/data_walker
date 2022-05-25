// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';
import 'package:random_unicode/random_unicode.dart';

/// Class to walk through the integers within the range
/// Use ListWalker<String> to walk through pre-defined strings
///
class StringWalker extends DataWalker<String> {
  /// Lowest possible value within the range
  ///
  final int minLength;

  /// Highest possible value within the range
  ///
  final int maxLength;

  /// Random Unicode string generator
  ///
  final RandomUnicode randomUnicode;

  /// Increment to move from the previous value to the next one
  ///
  final int stepLength;

  /// Default constructor
  ///
  StringWalker(this.randomUnicode, this.minLength, this.maxLength,
      {this.stepLength = 1,
      super.repeats,
      bool isRandomLength = false,
      super.random})
      : super(
            length: (stepLength == 0
                ? 0
                : ((maxLength - minLength + stepLength) ~/ stepLength)),
            isRandom: isRandomLength);

  /// Copy constructor
  ///
  StringWalker copyWith(
          {RandomUnicode? randomUnicode,
          int? minLength,
          int? maxLength,
          int? stepLength,
          int? repeats,
          bool? isRandomLength,
          Random? random}) =>
      StringWalker(randomUnicode ?? this.randomUnicode,
          minLength ?? this.minLength, maxLength ?? this.maxLength,
          stepLength: stepLength ?? this.stepLength,
          repeats: repeats ?? this.repeats,
          isRandomLength: isRandomLength ?? super.isRandom,
          random: random ?? super.random);

  /// Move to the next value
  ///
  @override
  String next([bool isNext = true]) =>
      randomUnicode.string(minLength + nextNo(isNext) * stepLength);
}
