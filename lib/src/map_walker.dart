// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'dart:math';

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

  /// Copy constructor
  ///
  MapWalker copyWith(
          {Map<K, V>? map, int? repeats, bool? isRandom, Random? random}) =>
      MapWalker(map ?? this.map,
          repeats: repeats ?? this.repeats,
          isRandom: isRandom ?? this.isRandom,
          random: random ?? this.random);

  /// Move to the next value
  ///
  @override
  MapEntry<K, V> next([bool isNext = true]) =>
      map.entries.elementAt(nextNo(isNext));
}
