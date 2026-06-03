import '../../../../utils/exports.dart';

import 'widget/widget.dart';

export 'model/model.dart';

/// Bottom navigation bar — themed sheet, rounded top, icon + label tabs.
class CustomBottomNavBar extends StatelessWidget {
  /// Creates [CustomBottomNavBar] with exactly [itemCount] tabs.
  const CustomBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.itemCount = 5,
    this.iconSize = Dimens.size24,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.activeIconBackgroundColor,
    this.topBorderRadius,
  });

  final List<CustomBottomNavBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  /// Expected number of tabs (default 5 for dashboard).
  final int itemCount;

  final double iconSize;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? activeIconBackgroundColor;
  final double? topBorderRadius;

  static const double _topRadius = 24;

  @override
  Widget build(BuildContext context) {
    assert(
      items.length == itemCount,
      'CustomBottomNavBar must have exactly $itemCount items, got ${items.length}',
    );

    final bool isDark = context.isDark;
    final Color active = activeColor ?? AppColors.primaryPurple;
    final Color inactive = inactiveColor ??
        (isDark
            ? AppColors.textSecondaryDark
            : const Color(0xFF9E9E9E));
    final Color activeIconBg = activeIconBackgroundColor ??
        AppColors.primaryPurple.withValues(alpha: isDark ? 0.22 : 0.12);
    final double radius = topBorderRadius ?? _topRadius;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark ? AppColors.surfaceDark : AppColors.whiteColor),
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.borderDark
                : AppColors.borderLight.withValues(alpha: 0.8),
          ),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.35)
                : const Color(0x1A000000),
            offset: const Offset(0, -2),
            blurRadius: 12,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.space4,
            Dimens.space6,
            Dimens.space4,
            Dimens.space4,
          ),
          child: Row(
            children: List<Widget>.generate(
              itemCount.clamp(0, items.length),
              (int index) => Expanded(
                child: NavBarItemWidget(
                  key: ValueKey<String>(items[index].routeName ?? '$index'),
                  item: items[index],
                  isSelected: index == currentIndex,
                  activeColor: active,
                  inactiveColor: inactive,
                  activeIconBackgroundColor: activeIconBg,
                  iconSize: iconSize,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
