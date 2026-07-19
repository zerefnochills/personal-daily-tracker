import 'package:flutter/foundation.dart';

/// Small in-memory mirror of settings that live in the profile row but
/// need to be read cheaply by lots of widgets (e.g. every dashboard tile
/// checking "should I animate?"). Kept intentionally tiny — if this grows
/// past 2-3 flags, it should become a proper state management setup
/// instead of a couple of static ValueNotifiers.
class AppSettings {
  static final ValueNotifier<bool> reduceMotion = ValueNotifier<bool>(false);
}
