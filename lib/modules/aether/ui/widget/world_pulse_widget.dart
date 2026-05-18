import '../../../../utils/exports.dart';
import '../../service/world_pulse_service.dart';

/// World-Pulse countdown — full-width hero banner.
///
/// Wrapped in [RepaintBoundary] so the raster cache for the raid and
/// chat panels survives every 100 ms tick. The only thing that
/// repaints is the digit row.
class WorldPulseWidget extends StatelessWidget {
  /// Creates a world-pulse banner bound to [service].
  const WorldPulseWidget({required this.service, super.key});

  /// Service that owns the 10 Hz [ValueNotifier].
  final WorldPulseService service;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Color(0xFFFF6A00),
              Color(0xFFB31217),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color(0xFFB31217).withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
          child: Row(
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'WORLD BOSS INCOMING',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ValueListenableBuilder<Duration>(
                      valueListenable: service.remaining,
                      builder:
                          (BuildContext context, Duration value, Widget? _) {
                        final String label = _format(value);
                        return Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'inter',
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                            height: 1.05,
                            fontFeatures: <FontFeature>[
                              FontFeature.tabularFigures(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.bolt,
                color: Colors.amberAccent,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _format(Duration d) {
    final int totalMs = d.inMilliseconds;
    final int minutes = totalMs ~/ 60000;
    final int seconds = (totalMs % 60000) ~/ 1000;
    final int tenths = (totalMs % 1000) ~/ 100;
    final String mm = minutes.toString().padLeft(2, '0');
    final String ss = seconds.toString().padLeft(2, '0');
    return '$mm:$ss.$tenths';
  }
}
