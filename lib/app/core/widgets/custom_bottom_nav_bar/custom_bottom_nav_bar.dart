import '../../../../utils/exports.dart';

/// Custom bottom navigation bar with pill-shaped container and animated tab items.
///
/// Features:
/// - Rounded pill-shaped container with white background and shadow
/// - Exactly 4 navigation items with active/inactive states
/// - Active item: green background (#34A853), white icon, slightly larger width
/// - Inactive items: light grey background (#F5F5F0), grey icons
/// - Smooth [AnimatedContainer] transition when changing tabs
/// - Responsive padding and spacing via [Dimens]
///
/// Use [CustomBottomNavBarItem] for each item (activeIcon, inactiveIcon as [Widget]).
class CustomBottomNavBar extends StatelessWidget {
  /// Creates a pill-shaped bottom nav bar with 4 items and animated selection.
  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.margin,
    this.backgroundColor,
    this.activeColor,
    this.inactiveBackgroundColor,
    this.inactiveIconColor,
    this.borderRadius,
    this.animationDuration,
    this.height,
  });

  /// List of exactly 4 bottom bar items.
  final List<CustomBottomNavBarItem> items;

  /// Currently selected item index (0–3).
  final int currentIndex;

  /// Called when an item is tapped with its index.
  final ValueChanged<int> onTap;

  /// Margin around the bottom bar container.
  final EdgeInsets? margin;

  /// Background color of the pill container. Defaults to white.
  final Color? backgroundColor;

  /// Background color of the active item. Defaults to #34A853.
  final Color? activeColor;

  /// Background color of inactive items. Defaults to #F5F5F0.
  final Color? inactiveBackgroundColor;

  /// Color of inactive icons. Defaults to grey.
  final Color? inactiveIconColor;

  /// Border radius of the outer pill. Defaults to [Dimens.radius30].
  final double? borderRadius;

  /// Duration of the tab change animation.
  final Duration? animationDuration;

  /// Height of the bottom bar. Defaults to 60.
  final double? height;

  static const int _itemCount = 4;

  static const double _defaultHeight = 60;

  /// Default horizontal margin (left/right).
  static const double _defaultHorizontalMargin = 30;

  /// Default bottom margin.
  static const double _defaultBottomMargin = 24;

  /// Active item background (green per design).
  static final Color _defaultActiveColor = MainConfig.appColors.primary;

  /// Inactive item background (light grey).
  static const Color _defaultInactiveBackgroundColor = AppColors.defaultInactiveBackgroundColor;

  @override
  Widget build(BuildContext context) {
    assert(
      items.length == _itemCount,
      'CustomBottomNavBar must have exactly $_itemCount items, got ${items.length}',
    );

    final Color activeBg = activeColor ?? _defaultActiveColor;
    final Color inactiveBg =
        inactiveBackgroundColor ?? _defaultInactiveBackgroundColor;
    final Duration duration =
        animationDuration ?? const Duration(milliseconds: Dimens.milliseconds300);

    Widget itemBuilder(int index) => Expanded(
          child: _NavBarItem(
            item: items[index],
            isSelected: index == currentIndex,
            activeBackgroundColor: activeBg,
            inactiveBackgroundColor: inactiveBg,
            animationDuration: duration,
            onTap: () => onTap(index),
          ),
        );

    final double barHeight = height ?? _defaultHeight;
    final EdgeInsets barMargin = margin ??
        const EdgeInsets.only(
          left: _defaultHorizontalMargin,
          right: _defaultHorizontalMargin,
          bottom: _defaultBottomMargin,
        );

    return Container(
      margin: barMargin,
      height: barHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.whiteColor,
          borderRadius: BorderRadius.circular(borderRadius ?? Dimens.radius30),
          boxShadow: <BoxShadow>[
            const BoxShadow(
              color: AppColors.blackWithDarkerShade,
              blurRadius: Dimens.blurRadius4,
              offset: Offset(0, Dimens.offset4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space10),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: always_specify_types - List.generate callback type is inferred from itemBuilder.
          children: List.generate(
            _itemCount.clamp(0, items.length),
            itemBuilder,
          ),
        ),
      ),
    ),
    );
  }
}

/// Single tab item with animated pill and icon.
class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.activeBackgroundColor,
    required this.inactiveBackgroundColor,
    required this.animationDuration,
    required this.onTap,
  });

  final CustomBottomNavBarItem item;
  final bool isSelected;
  final Color activeBackgroundColor;
  final Color inactiveBackgroundColor;
  final Duration animationDuration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radius20),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: AnimatedContainer(
            duration: animationDuration,
            curve: Curves.easeInOut,
            height: Dimens.size40,
            width:Dimens.size68 ,
            decoration: BoxDecoration(
              color: isSelected
                  ? activeBackgroundColor
                  : inactiveBackgroundColor,
              borderRadius: BorderRadius.circular(Dimens.radius20),
            ),
            child: Center(
              child: isSelected ? item.activeIcon : item.inactiveIcon,
            ),
          ),
        ),
      ),
    );
  }
}

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
