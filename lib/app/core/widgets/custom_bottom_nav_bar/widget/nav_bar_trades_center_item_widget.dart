import '../../../../../utils/exports.dart';

import 'nav_bar_selection_animation.dart';

/// Center Trades tab — fixed height; gradient circle only when selected.
class NavBarTradesCenterItemWidget extends StatelessWidget {
  const NavBarTradesCenterItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  final CustomBottomNavBarItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  /// Fixed size — same as other nav tabs so bar height stays constant.
  static const double _iconBoxSize = 44;
  static const double _indicatorWidth = 28;
  static const double _indicatorHeight = 3;
  static const double _indicatorSlotHeight = 6;

  @override
  Widget build(BuildContext context) {
    final Color targetIconColor =
        isSelected ? AppColors.whiteColor : inactiveColor;
    final Color targetLabelColor = isSelected ? activeColor : inactiveColor;

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
              transform: Matrix4.translationValues(
                0,
                isSelected ? -8.0 : -3.0,
                0,
              ),
              width: _iconBoxSize,
              height: _iconBoxSize,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AnimatedOpacity(
                    duration: NavBarSelectionAnimation.duration,
                    curve: NavBarSelectionAnimation.curve,
                    opacity: isSelected ? 1 : 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppColors.primaryButtonGradient,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.primaryPurple.withValues(
                              alpha: 0.35,
                            ),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const SizedBox(
                        width: _iconBoxSize,
                        height: _iconBoxSize,
                      ),
                    ),
                  ),
                  TweenAnimationBuilder<Color?>(
                    duration: NavBarSelectionAnimation.duration,
                    curve: NavBarSelectionAnimation.curve,
                    tween: ColorTween(end: targetIconColor),
                    builder: (
                      BuildContext context,
                      Color? color,
                      Widget? child,
                    ) {
                      return Assets.png.icWekoWhiteCrop.image(
                        color: color ?? targetIconColor,
                        height: Dimens.size22,
                        width: Dimens.size22,
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space4),
            if (item.label != null && item.label!.isNotEmpty)
              AnimatedDefaultTextStyle(
                duration: NavBarSelectionAnimation.duration,
                curve: NavBarSelectionAnimation.curve,
                style: TextStyle(
                  fontSize: Dimens.fontSize11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: targetLabelColor,
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
}
