import 'package:flutter/material.dart';

/// A widget that rotates an icon based on language alignment.
///
/// This is useful for apps that support both LTR (Left-to-Right) and RTL (Right-to-Left)
/// languages, where icons such as back arrows need to be flipped for proper orientation.
class RotatedIcon extends StatelessWidget {
  /// Whether the language alignment is Left-to-Right.
  ///
  /// If `true`, the icon will not be flipped.
  /// If `false`, the icon will be rotated to match RTL layout.
  final bool isLanguageAlignmentLTR;

  /// The icon widget to be rotated.
  final Widget iconWidget;

  /// Creates a [RotatedIcon].
  ///
  /// Both [isLanguageAlignmentLTR] and [iconWidget] are required.
  const RotatedIcon({
    super.key,
    required this.isLanguageAlignmentLTR,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: isLanguageAlignmentLTR ? 4 : 2,
      child: iconWidget,
    );
  }
}
