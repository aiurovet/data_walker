// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

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

  /// Get the current value
  ///
  @override
  T current() => (currentNo < 0 ? next() : iterable.elementAt(currentNo));

  /// Move to the next value
  ///
  @override
  T next() => iterable.elementAt(nextIndex());

  /// Reset index and move to the first element
  ///
  @override
  T reset() => iterable.elementAt(resetIndex());
}
