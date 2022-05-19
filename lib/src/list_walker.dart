// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

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

  /// Get the current value
  ///
  @override
  T current() => (currentNo < 0 ? next() : list[currentNo]);

  /// Move to the next value
  ///
  @override
  T next() => list[nextIndex()];

  /// Reset index and move to the first element
  ///
  @override
  T reset() => list[resetIndex()];
}