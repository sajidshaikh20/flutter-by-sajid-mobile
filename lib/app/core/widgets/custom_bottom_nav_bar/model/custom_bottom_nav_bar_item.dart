import 'package:flutter/widgets.dart';

/// Data model for one bottom nav bar item.
class CustomBottomNavBarItem {
  /// Creates a bottom nav item.
  const CustomBottomNavBarItem({
    this.activeIcon,
    this.inactiveIcon,
    this.iconBuilder,
    this.routeName,
    this.label,
  }) : assert(
          iconBuilder != null ||
              (activeIcon != null && inactiveIcon != null),
          'Provide iconBuilder or both activeIcon and inactiveIcon',
        );

  /// Icon when selected (legacy).
  final Widget? activeIcon;

  /// Icon when not selected (legacy).
  final Widget? inactiveIcon;

  /// Builds icon with theme color and size (preferred).
  final Widget Function(Color color, double size)? iconBuilder;

  /// Optional route or identifier for navigation.
  final String? routeName;

  /// Tab label shown below the icon.
  final String? label;
}
