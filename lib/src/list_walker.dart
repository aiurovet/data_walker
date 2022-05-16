// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';

/// Class to organise supply of indices
///
class ListWalker<T> extends IndexWalker {
  /// The actual list (must not be empty)
  ///
  final List<T> list;

  /// The constructor
  ///
  ListWalker(this.list, {super.runCount, super.isRandom, super.random}) :
    super(length: list.length);

  /// Set [current] to the next value
  ///
  T next() {
    final i = nextIndex();

    return list[i];
  }

  /// Reset [durrent] and [runNo]
  ///
  T reset() {
    return list[resetIndex()];
  }
}
