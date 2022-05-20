// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';

/// Type for the value processing handler
///
typedef DataWalkerMapProc<K> = bool Function(Map<K, Object> values);

/// Aggregator for DataWalkers
///
extension DataWalkerMap<K, D extends DataWalker> on Map<K, D> {
  /// Dummy map proc
  ///
  bool dummyMapProc(Map<K, Object> values) => true;

  /// Execution starting point
  /// Returns false if [mapProc] or [_exec] returned false
  ///
  bool exec({DataWalkerMapProc? mapProc, int repeats = 1}) {
    final mapProcEx = mapProc ?? dummyMapProc;

    for (var i = 0; i < repeats; i++) {
      if (!_exec(<K, Object>{}, 0, mapProcEx)) {
        return false;
      }
    }
    return true;
  }

  /// Execution recursion point
  /// Returns false if [mapProc] or subsequent recursive call return false
  ///
  bool _exec(Map<K, Object> values, int i, DataWalkerMapProc<K> mapProc) {
    // Initialize current waker data
    //
    final entry = entries.elementAt(i);
    final key = entry.key;
    final walker = entry.value;
    final walkerLastNo = walker.lastNo;

    // Ensure the walker is not empty
    //
    if (walkerLastNo < 0) {
      return true;
    }

    // Reset the walker's all counters and run through all its values once
    //
    final isLast = (i >= length - 1);

    do {
      values[key] = walker.next();

      if (isLast) {
        if (!mapProc(values)) {
          return false;
        }
      } else if (!_exec(values, i + 1, mapProc)) {
        return false;
      }
    } while (walker.currentNo <= walkerLastNo);

    return true;
  }
}
