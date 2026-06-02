import 'dart:math' as math;

import '../../../utils/exports.dart';

/// Custom painter to paint the dynamic bottom wave dotted grid.
class WaveDottedPainter extends CustomPainter {
  /// Color of the dotted grid waves.
  final Color color;

  /// Creates a WaveDottedPainter.
  WaveDottedPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // 6 rows of dots offset by a sine wave to create overlapping wave grids
    const int rows = 6;
    const double rowSpacing = 18.0;

    // Position the pattern starting from 70% height down to 90%
    final double startY = size.height * 0.70;

    for (int r = 0; r < rows; r++) {
      final double currentBaseY = startY + (r * rowSpacing);

      // Gradually make the dots slightly more opaque as we go down
      final Color rowColor = color.withValues(alpha: (r + 1.5) / (rows + 1.5) * color.a);
      final Paint rowPaint = Paint()
        ..color = rowColor
        ..style = PaintingStyle.fill;

      for (double x = 0; x < size.width + 10; x += 14) {
        // Sine wave offset: period is size.width, amplitude is 12, phase shift per row
        final double y = currentBaseY + math.sin((x / size.width) * 2 * math.pi + (r * 0.5)) * 12;
        canvas.drawCircle(Offset(x, y), 2.2, rowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

