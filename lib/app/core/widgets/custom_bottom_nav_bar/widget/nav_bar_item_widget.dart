import 'package:flutter/material.dart';

import '../../../theme/dimens.dart';
import '../model/custom_bottom_nav_bar_item.dart';

/// Single tab item with animated pill and icon.
class NavBarItemWidget extends StatelessWidget {
  const NavBarItemWidget({
    super.key,
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
            width: Dimens.size68,
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
