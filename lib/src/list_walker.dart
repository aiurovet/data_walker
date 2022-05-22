// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

import 'package:data_walker/data_walker.dart';

/// Class to walk through list elements
///
class ListWalker<T> extends DataWalker<T> {
  /// The actual list (must not be empty)
  ///
  final List<T> list;

  /// The constructor
  ///
  ListWalker(this.list, {super.repeats, super.isRandom, super.random})
      : super(length: list.length);

  /// Copy constructor
  ///
  ListWalker copyWith(
          {List<T>? list,
          num? max,
          int? step,
          int? repeats,
          bool? isRandom,
          Random? random}) =>
      ListWalker(list ?? this.list,
          repeats: repeats ?? this.repeats,
          isRandom: isRandom ?? this.isRandom,
          random: random ?? this.random);

  /// Move to the next value
  ///
  @override
  T next([bool isNext = true]) => list[nextNo(isNext)];
}
