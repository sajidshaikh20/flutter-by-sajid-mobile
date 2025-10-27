import '../../../../utils/exports.dart';

/// Model class for row item data in account screens.
class RowItemModel {
  /// The title of the row item.
  final String title;

  /// The subtitle of the row item.
  final String? subtitle;

  /// Whether to use different styling.
  final bool isDifferentStyle;

  /// Whether to show a dialog when tapped.
  final bool? isShowDialog;

  /// The route for navigation when tapped.
  final PageRouteInfo? route;

  /// Creates an instance of [RowItemModel].
  RowItemModel({
    required this.title,
    this.subtitle,
    this.isShowDialog,
    this.isDifferentStyle = false,
    this.route,
  });
}
