import 'package:flutter/widgets.dart';

/// Data model for one bottom nav bar item.
///
/// [activeIcon] is shown when the item is selected (e.g. white icon).
/// [inactiveIcon] is shown when not selected (e.g. grey icon).
/// Use [routeName] for navigation or analytics; [label] is optional.
class CustomBottomNavBarItem {
  /// Creates a bottom nav item with [activeIcon] and [inactiveIcon] widgets.
  const CustomBottomNavBarItem({
    required this.activeIcon,
    required this.inactiveIcon,
    this.routeName,
    this.label,
  });

  /// Icon widget when the item is selected (e.g. white icon on green).
  final Widget activeIcon;

  /// Icon widget when the item is not selected (e.g. grey icon).
  final Widget inactiveIcon;

  /// Optional route or identifier for navigation.
  final String? routeName;

  /// Optional label for accessibility or debugging.
  final String? label;
}
