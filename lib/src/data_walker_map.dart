// Copyright (c) 2022, Alexander Iurovetski
// All rights reserved under MIT license (see LICENSE file)

import 'package:data_walker/data_walker.dart';

/// Type for the value processing handler
///
typedef DataWalkerMapProc = void Function(Map values);

/// Aggregator for DataWalkers
///
extension DataWalkerMap<K, V extends DataWalker> on Map<K, V> {
  /// Execution starting point
  /// Returns false if [valueProc] or [_exec] returned false
  ///
  bool exec({DataWalkerMapProc? valueProc, int repeats = 1}) {
    for (var i = 0; i < repeats; i++) {
      _exec({}, 0, valueProc);
    }
    return true;
  }

  /// Execution recursion point
  /// Returns false if [valueProc] or subsequent recursive call return false
  ///
  void _exec(Map values, int walkerNo, DataWalkerMapProc? valueProc) {
    // Initialize current waker data
    //
    final entry = entries.elementAt(walkerNo);
    final key = entry.key;
    final walker = entry.value;
    final walkerRepeats = walker.repeats;

    // Ensure the current walker is not empty
    //
    if ((walker.lastNo < 0) || (walkerRepeats <= 0)) {
      return;
    }

    // Reset the walker's all counters and run through all its values once
    //
    walker.reset();

    final isLastWalker = (walkerNo >= length - 1);

    while (true) {
      final nextValue = walker.next();

      if (walker.isFinished) {
        break;
      }

      values[key] = nextValue;

      if (isLastWalker) {
        if (valueProc != null) {
          valueProc(values);
        }
      } else {
        _exec(values, walkerNo + 1, valueProc);
      }
    }
  }

  /// Returns comma-separated pairs of 'key: value'
  /// Useful for printing the name of a test as a list of its parameters
  ///
  String valuesToString(Map values,
      {String? prefix,
      String? suffix,
      bool quoteStrings = true,
      bool useKeys = true}) {
    final result = StringBuffer();

    if ((prefix != null) && prefix.isNotEmpty) {
      result.write(prefix);
    }

    values.forEach((key, value) {
      if (result.isNotEmpty) {
        result.write(', ');
      }

      if (useKeys) {
        final keyStr = key.toString();

        if (keyStr.isNotEmpty) {
          result
            ..write(keyStr)
            ..write(': ');
        }
      }

      if (quoteStrings && (value is String)) {
        result.write('"$value"');
      } else {
        result.write(value.toString());
      }
    });

    if ((suffix != null) && suffix.isNotEmpty) {
      result.write(suffix);
    }

    return result.toString();
  }
}
