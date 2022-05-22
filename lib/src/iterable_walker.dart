// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';

/// Class to walk through list elements
///
class IterableWalker<T> extends DataWalker<T> {
  /// The actual list (must not be empty)
  ///
  final Iterable<T> iterable;

  /// The constructor
  ///
  IterableWalker(this.iterable, {super.repeats, super.isRandom, super.random})
      : super(length: iterable.length);

  /// Copy constructor
  ///
  IterableWalker copyWith(
          {Iterable? iterable,
          num? max,
          int? step,
          int? repeats,
          bool? isRandom,
          Random? random}) =>
      IterableWalker(iterable ?? this.iterable,
          repeats: repeats ?? this.repeats,
          isRandom: isRandom ?? this.isRandom,
          random: random ?? this.random);

  /// Move to the next value
  ///
  @override
  T next([bool isNext = true]) => iterable.elementAt(nextNo(isNext));
}
