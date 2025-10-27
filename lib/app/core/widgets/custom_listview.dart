import '../../../utils/exports.dart';

/// A custom list view widget that provides a flexible way to display a list of items
/// with optional separators, scroll direction, physics, and other customizable properties.
class CustomListView extends StatelessWidget {
  /// A builder function that creates a widget for each item in the list.
  final Widget? Function(BuildContext, int) itemBuilder;

  /// The total number of items in the list.
  final int itemCount;

  /// The direction in which the list scrolls. Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// The scroll physics to use for the list.
  final ScrollPhysics? scrollPhysics;

  /// The scroll controller to use for the list.
  final ScrollController? scrollController;

  /// Whether to show separators between list items. Defaults to false.
  final bool? isSeparator;

  /// The height of the separator. Defaults to [Dimens.space1].
  final double? divHeight;

  /// The color of the separator. Defaults to .
  final Color? divColor;

  /// Whether to add padding to the list. Defaults to false.
  final bool isPadding;

  /// Creates a custom list view with the specified properties.
  ///
  /// [itemBuilder] is a callback function that builds each item in the list.
  /// [itemCount] is the total number of items in the list.
  /// [scrollDirection] determines whether the list scrolls vertically or horizontally.
  /// [scrollPhysics] sets the scrolling physics for the list.
  /// [scrollController] allows for programmatic control of the list's scroll position.
  /// [isSeparator] controls whether separators are displayed between items.
  /// [divHeight] specifies the height of the separators.
  /// [divColor] sets the color of the separators.
  /// [isPadding] determines whether padding is applied around the list.
  const CustomListView({
    super.key,
    required this.itemBuilder,
    this.scrollPhysics,
    required this.itemCount,
    this.scrollDirection = Axis.vertical,
    this.scrollController,
    this.isSeparator,
    this.divHeight,
    this.divColor,
    this.isPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      shrinkWrap: true,
      padding: isPadding ? EdgeInsets.zero : null,
      physics: scrollPhysics,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: (BuildContext context, int index) {
        return Visibility(
            visible: isSeparator ?? false,
            child: CustomDivider(
              height: (divHeight != null) ? divHeight : Dimens.space1,
              color: (divColor != null) ? divColor : MainConfig.appColors.dividerColor,
            ));
      },
    );
  }
}
