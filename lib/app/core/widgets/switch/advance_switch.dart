import '../../../../utils/exports.dart';

/// A customizable switch widget with advanced features.
///
/// [AdvancedSwitch] is a toggle switch that supports:
/// - Custom colors for active and inactive states
/// - Optional labels or icons for both states
/// - Optional background images for both states
/// - Customizable border radius, size, and thumb widget
/// - Smooth animations for color and thumb movement
/// - Support for enabling/disabling the switch
///
/// Example:
/// ```dart
/// AdvancedSwitch(
///   activeChild: Text('On'),
///   inactiveChild: Text('Off'),
///   activeColor: Colors.green,
///   inactiveColor: Colors.red,
///   initialValue: true,
///   onChanged: (value) {
///     print('Switch changed: $value');
///   },
/// )
/// ```
class AdvancedSwitch extends StatefulWidget {
  /// Creates an [AdvancedSwitch] with customizable appearance and behavior.
  ///
  /// - [activeColor] and [inactiveColor] have default values if not provided.
  /// - [width] defaults to [Dimens.size50] and [height] to [Dimens.size30].
  /// - [borderRadius] defaults to circular with radius [Dimens.radius15].
  AdvancedSwitch({
    super.key,
    this.controller,
    Color? activeColor,
    Color? inactiveColor,
    this.activeChild,
    this.inactiveChild,
    this.activeImage,
    this.inactiveImage,
    this.borderRadius =
    const BorderRadius.all(Radius.circular(Dimens.radius15)),
    this.width = Dimens.size50,
    this.height = Dimens.size30,
    this.enabled = true,
    this.disabledOpacity = Dimens.opacity05,
    this.thumb,
    this.initialValue = false,
    this.onChanged,
  })  : activeColor = activeColor ?? MainConfig.appColors.mainColor,
        inactiveColor = inactiveColor ?? MainConfig.appColors.greyDark;

  /// Determines if the widget is enabled.
  ///
  /// If false, user interaction is disabled, and the switch appears dimmed
  /// based on [disabledOpacity].
  final bool enabled;

  /// An optional controller to externally manage the switch's state.
  ///
  /// If null, the widget manages its own state internally.
  final ValueNotifier<bool>? controller;

  /// The background color for the active state.
  final Color activeColor;

  /// The background color for the inactive state.
  final Color inactiveColor;

  /// The widget displayed when the switch is in the active state.
  final Widget? activeChild;

  /// The widget displayed when the switch is in the inactive state.
  final Widget? inactiveChild;

  /// The background image used when the switch is active.
  final ImageProvider? activeImage;

  /// The background image used when the switch is inactive.
  final ImageProvider? inactiveImage;

  /// The border radius of the switch background.
  final BorderRadius borderRadius;

  /// The width of the switch.
  final double width;

  /// The height of the switch.
  final double height;

  /// The opacity applied when [enabled] is false.
  final double disabledOpacity;

  /// The widget used as the thumb (slider handle).
  ///
  /// If null, a default white circular thumb with shadow is used.
  final Widget? thumb;

  /// The initial state value when the switch is first built.
  ///
  /// Defaults to `false`.
  final bool initialValue;

  /// Callback triggered when the switch's value changes.
  final ValueChanged<bool>? onChanged;

  @override
  AdvancedSwitchState createState() => AdvancedSwitchState();
}
/// Class AdvancedSwitchState
class AdvancedSwitchState extends State<AdvancedSwitch>
    with SingleTickerProviderStateMixin {
  static const Duration _duration =
  Duration(milliseconds: Dimens.milliseconds300);

  late ValueNotifier<bool> _controller;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<Color?> _colorAnimation;
  late double _thumbSize;

  @override
  void initState() {
    super.initState();

    _controller = ValueNotifier<bool>(widget.initialValue);
    _valueController.addListener(_handleControllerValueChanged);

    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
      value: _controller.value ? 1.0 : 0.0,
    );

    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant AdvancedSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    oldWidget.controller?.removeListener(_handleControllerValueChanged);
    _valueController
      ..removeListener(_handleControllerValueChanged)
      ..addListener(_handleControllerValueChanged);

    if (oldWidget.initialValue != widget.initialValue) {
      _valueController.value = widget.initialValue;
    }

    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final double labelSize = widget.width - _thumbSize;
    final double containerSize = labelSize * 2 + _thumbSize;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handlePressed,
        child: Opacity(
          opacity: _isEnabled ? 1 : widget.disabledOpacity,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, Widget? child) {
              return ClipRRect(
                borderRadius: widget.borderRadius,
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  color: _colorAnimation.value,
                  child: child,
                ),
              );
            },
            child: Stack(
              children: <Widget>[
                if (widget.activeImage != null || widget.inactiveImage != null)
                  ValueListenableBuilder<bool>(
                    valueListenable: _valueController,
                    builder: (_, bool value, ___) {
                      return AnimatedCrossFade(
                        crossFadeState: value
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: _duration,
                        firstChild: Image(
                          width: widget.width,
                          height: widget.height,
                          image: widget.inactiveImage ?? widget.activeImage!,
                          fit: BoxFit.cover,
                        ),
                        secondChild: Image(
                          width: widget.width,
                          height: widget.height,
                          image: widget.activeImage ?? widget.inactiveImage!,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: _slideAnimation.value,
                      child: child,
                    );
                  },
                  child: OverflowBox(
                    minWidth: containerSize,
                    maxWidth: containerSize,
                    minHeight: widget.height,
                    maxHeight: widget.height,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconTheme(
                          data: IconThemeData(
                            color: MainConfig.appColors.backgroundWhite,
                            size: Dimens.size20,
                          ),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: MainConfig.appColors.backgroundWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.fontSize12,
                            ),
                            child: Container(
                              width: labelSize,
                              height: widget.height,
                              alignment: Alignment.center,
                              child: widget.activeChild,
                            ),
                          ),
                        ),
                        Container(
                          margin: Dimens.space2.padding,
                          width: _thumbSize - Dimens.size4,
                          height: _thumbSize - Dimens.size4,
                          child: widget.thumb ??
                              Container(
                                decoration: BoxDecoration(
                                  color: MainConfig.appColors.backgroundWhite,
                                  borderRadius: widget.borderRadius.subtract(
                                      Dimens.radius1.borderRadius),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                      color: Color(0x42000000),
                                      blurRadius: Dimens.blurRadius8,
                                    ),
                                  ],
                                ),
                              ),
                        ),
                        IconTheme(
                          data: IconThemeData(
                            color: MainConfig.appColors.backgroundWhite,
                            size: Dimens.size20,
                          ),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              color: MainConfig.appColors.backgroundWhite,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.fontSize12,
                            ),
                            child: Container(
                              width: labelSize,
                              height: widget.height,
                              alignment: Alignment.center,
                              child: widget.inactiveChild,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ValueNotifier<bool> get _valueController =>
      widget.controller ?? _controller;

  bool get _isEnabled =>
      widget.enabled &&
          (widget.controller != null || widget.onChanged != null);

  void _initAnimation() {
    _thumbSize = widget.height;
    final double offset = widget.width / 2 - _thumbSize / 2;

    final CurvedAnimation animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(-offset, 0),
      end: Offset(offset, 0),
    ).animate(animation);

    _colorAnimation = ColorTween(
      begin: widget.inactiveColor,
      end: widget.activeColor,
    ).animate(animation);
  }

  void _handleControllerValueChanged() {
    final bool nextValue = _valueController.value;
    widget.onChanged?.call(nextValue);

    if (nextValue) {
      unawaited(_animationController.forward());
    } else {
      unawaited(_animationController.reverse());
    }
  }

  void _handlePressed() {
    if (!_isEnabled) return;
    _valueController.value = !_valueController.value;
  }

  @override
  void dispose() {
    _valueController.removeListener(_handleControllerValueChanged);
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
