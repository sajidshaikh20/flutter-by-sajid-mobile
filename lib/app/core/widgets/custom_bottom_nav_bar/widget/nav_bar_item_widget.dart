import 'package:flutter/material.dart';

import '../../../theme/dimens.dart';
import '../model/custom_bottom_nav_bar_item.dart';
import 'nav_bar_selection_animation.dart';

/// Single bottom-nav tab: icon tile, label, underline indicator.
class NavBarItemWidget extends StatelessWidget {
  const NavBarItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeIconBackgroundColor,
    required this.iconSize,
    required this.onTap,
  });

  final CustomBottomNavBarItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeIconBackgroundColor;
  final double iconSize;
  final VoidCallback onTap;

  static const double _iconBoxSize = 44;
  static const double _indicatorWidth = 28;
  static const double _indicatorHeight = 3;
  static const double _indicatorSlotHeight = 6;

  @override
  Widget build(BuildContext context) {
    final Color targetIconColor = isSelected ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedContainer(
              duration: NavBarSelectionAnimation.duration,
              curve: NavBarSelectionAnimation.curve,
              width: _iconBoxSize,
              height: _iconBoxSize,
              decoration: BoxDecoration(
                color: isSelected
                    ? activeIconBackgroundColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimens.radius12),
              ),
              alignment: Alignment.center,
              child: _buildIcon(targetIconColor),
            ),
            const SizedBox(height: Dimens.space4),
            if (item.label != null && item.label!.isNotEmpty)
              AnimatedDefaultTextStyle(
                duration: NavBarSelectionAnimation.duration,
                curve: NavBarSelectionAnimation.curve,
                style: TextStyle(
                  fontSize: Dimens.fontSize11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: targetIconColor,
                  height: 1.1,
                ),
                child: Text(
                  item.label!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: Dimens.space4),
            SizedBox(
              height: _indicatorSlotHeight,
              child: Center(
                child: AnimatedContainer(
                  duration: NavBarSelectionAnimation.duration,
                  curve: NavBarSelectionAnimation.curve,
                  width: isSelected ? _indicatorWidth : 0,
                  height: _indicatorHeight,
                  decoration: BoxDecoration(
                    color: isSelected ? activeColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimens.radius2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color iconColor) {
    if (item.iconBuilder != null) {
      return TweenAnimationBuilder<Color?>(
        duration: NavBarSelectionAnimation.duration,
        curve: NavBarSelectionAnimation.curve,
        tween: ColorTween(end: iconColor),
        builder: (BuildContext context, Color? color, Widget? child) {
          return item.iconBuilder!(color ?? iconColor, iconSize);
        },
      );
    }

    final Widget icon = isSelected ? item.activeIcon! : item.inactiveIcon!;
    return AnimatedSwitcher(
      duration: NavBarSelectionAnimation.duration,
      switchInCurve: NavBarSelectionAnimation.curve,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: KeyedSubtree(
        key: ValueKey<bool>(isSelected),
        child: icon,
      ),
    );
  }
}
