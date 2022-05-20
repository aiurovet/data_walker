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

  /// Move to the next value
  ///
  @override
  T next([bool isNext = true]) => iterable.elementAt(nextNo(isNext));
}
