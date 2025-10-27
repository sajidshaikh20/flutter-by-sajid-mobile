import '../../../utils/exports.dart';

/// A customizable animated switch widget that toggles between two states.
///
/// The switch uses a sliding circle animation to indicate its state.
/// The animation direction automatically adapts to the current [TextDirection].
///
/// Example:
/// ```dart
/// CustomSwitch(
///   value: isEnabled,
///   onChanged: (newValue) {
///     setState(() => isEnabled = newValue);
///   },
/// )
/// ```
class CustomSwitch extends StatefulWidget {
  /// Whether the switch is currently ON (`true`) or OFF (`false`).
  final bool value;

  /// Called when the switch is tapped and its value changes.
  final ValueChanged<bool> onChanged;

  /// Creates a [CustomSwitch].
  ///
  /// The [value] and [onChanged] parameters must not be null.
  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomSwitch> createState() => CustomSwitchState();
}

/// The state class for [CustomSwitch].
///
/// Controls the animation and toggling behavior of the switch.
class CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<Alignment> _circleAnimation;
  /// Indicates whether the first circle is currently visible on the UI.
  bool isFirstCircleVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: Dimens.milliseconds500,
      ),
    );

    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (_animationController.isCompleted) {
          unawaited(_animationController.reverse());
        } else {
          unawaited(_animationController.forward());
        }
        widget.onChanged(!widget.value);
        setState(() {
          isFirstCircleVisible = !isFirstCircleVisible;
        });
      },
      child: Container(
        width: Dimens.size56,
        height: Dimens.size36,
        decoration: BoxDecoration(
          borderRadius: Dimens.space28.borderRadius,
          color: widget.value
              ? MainConfig.appColors.mainColor
              : MainConfig.appColors.backgroundGrey,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: _circleAnimation.value,
              child: Container(
                alignment: widget.value
                    ? (Directionality.of(context) == TextDirection.rtl
                    ? Alignment.centerLeft
                    : Alignment.centerRight)
                    : (Directionality.of(context) == TextDirection.rtl
                    ? Alignment.centerRight
                    : Alignment.centerLeft),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.space3,
                  ),
                  width: Dimens.size28,
                  height: Dimens.size28,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
