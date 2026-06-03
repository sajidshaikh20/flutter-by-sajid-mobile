import '../../../../../utils/exports.dart';

/// Center Trades tab — gradient circle when selected, subtle lift.
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

  /// Base icon tile size (aligned with other nav tabs).
  static const double _iconBoxSize = 44;

  static const double _sizeSelected = 48;
  static const double _liftSelected = 6;
  static const double _indicatorWidth = 28;
  static const double _indicatorHeight = 3;
  static const double _indicatorSlotHeight = 6;

  static const Duration _animDuration =
      Duration(milliseconds: Dimens.milliseconds300);

  @override
  Widget build(BuildContext context) {
    final double circleSize = isSelected ? _sizeSelected : _iconBoxSize;
    final Color iconColor = isSelected ? AppColors.whiteColor : inactiveColor;
    final Color labelColor = isSelected ? activeColor : inactiveColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
        child: AnimatedContainer(
          duration: _animDuration,
          curve: Curves.easeOutCubic,
          transform: isSelected
              ? Matrix4.translationValues(0, -_liftSelected, 0)
              : Matrix4.identity(),
          transformAlignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedContainer(
                duration: _animDuration,
                curve: Curves.easeOutCubic,
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected ? AppColors.primaryButtonGradient : null,
                  color: isSelected ? null : Colors.transparent,
                  boxShadow: isSelected
                      ? <BoxShadow>[
                          BoxShadow(
                            color: AppColors.primaryPurple.withValues(
                              alpha: 0.4,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.show_chart_rounded,
                  color: iconColor,
                  size: isSelected ? Dimens.size24 : Dimens.size22,
                ),
              ),
              const SizedBox(height: Dimens.space4),
              if (item.label != null && item.label!.isNotEmpty)
                Text(
                  item.label!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Dimens.fontSize11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: labelColor,
                    height: 1.1,
                  ),
                ),
              const SizedBox(height: Dimens.space4),
              SizedBox(
                height: _indicatorSlotHeight,
                child: Center(
                  child: Container(
                    width: _indicatorWidth,
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
      ),
    );
  }
}
