import 'dart:async';

import 'package:flutter/foundation.dart';

/// WorldPulseService — drives the 100 ms World-Boss countdown.
///
/// @AETHER: We deliberately do NOT use `setState` on a top-level widget
/// to drive a 10 Hz timer — that rebuilds the entire screen ten times
/// per second. Instead we publish through a [ValueNotifier] so only the
/// `ValueListenableBuilder` subtree (a single `Text` widget wrapped in
/// a `RepaintBoundary`) repaints. The chat list, the raid button and
/// the scaffold chrome are completely unaffected.
class WorldPulseService {
  /// Creates a pulse that ticks until [bossSpawnAt].
  WorldPulseService({required DateTime bossSpawnAt})
      : _bossSpawnAt = bossSpawnAt,
        remaining = ValueNotifier<Duration>(
          _computeRemaining(bossSpawnAt),
        );

  final DateTime _bossSpawnAt;

  /// Listenable consumed by the UI. The value is replaced every 100 ms;
  /// listeners get a cheap pointer-comparison rebuild.
  final ValueNotifier<Duration> remaining;

  Timer? _ticker;

  static const Duration _tickRate = Duration(milliseconds: 100);

  /// Begin emitting ticks. Safe to call multiple times — subsequent
  /// calls are no-ops until [dispose] is invoked.
  void start() {
    if (_ticker != null) {
      return;
    }
    // Fire once synchronously so the UI doesn't render a stale value
    // for up to 100 ms after mount.
    remaining.value = _computeRemaining(_bossSpawnAt);
    _ticker = Timer.periodic(_tickRate, (Timer _) {
      remaining.value = _computeRemaining(_bossSpawnAt);
    });
  }

  /// Cancels the ticker and releases the notifier. Required by the
  /// `cancel_subscriptions` lint and to keep us off the leak monitor
  /// when the user leaves the screen.
  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    remaining.dispose();
  }

  static Duration _computeRemaining(DateTime spawnAt) {
    final Duration diff = spawnAt.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }
}
