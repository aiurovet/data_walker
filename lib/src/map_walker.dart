// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';

/// Class to walk through list elements
///
class MapWalker<K, V> extends DataWalker<MapEntry<K, V>> {
  /// The actual list (must not be empty)
  ///
  final Map<K, V> map;

  /// The constructor
  ///
  MapWalker(this.map, {super.repeats, super.isRandom, super.random})
      : super(length: map.length);

  /// Get the current value
  ///
  @override
  MapEntry<K, V> current() =>
      (currentNo < 0 ? next() : map.entries.elementAt(currentNo));

  /// Move to the next value
  ///
  @override
  MapEntry<K, V> next() => map.entries.elementAt(nextIndex());

  /// Reset index and move to the first element
  ///
  @override
  MapEntry<K, V> reset() => map.entries.elementAt(resetIndex());
}